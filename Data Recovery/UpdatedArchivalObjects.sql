use Prod20160120;
SELECT 
    CONCAT('/resources/',
            r.id,
            '#tree::archival_object_',
            ao.id) 'archival object URL',
    repo.repo_code,
    r.identifier 'call number',
    r.title 'collection',
    ao.title,
    ao.ref_id,
    level.value level,
    lang.value language,
    ao.repository_processing_note,
    e.number AS 'extent number',
    ev.value AS 'extent type',
    e.container_summary,
    dti.value 'date type',
    li.value 'date label',
    d.expression,
    d.begin,
    d.end,
    CAST(note.notes AS CHAR (10000) CHARACTER SET UTF8),
        itype.value AS 'instance type',
    CONCAT('/plugins/top_containers/',
            tc.id) AS container_URL,
    tc.indicator AS box,
    tc.barcode AS barcode,
    cp.name AS 'container profile',
    l.title AS location,
    ao.created_by,
    ao.create_time,
    ao.last_modified_by,
    ao.system_mtime
FROM
    archival_object ao
        LEFT JOIN
    resource r ON r.id = ao.root_record_id
        LEFT JOIN
    date d ON d.archival_object_id = ao.id
        LEFT JOIN
    enumeration_value dti ON d.date_type_id = dti.id
        LEFT JOIN
    enumeration_value li ON d.label_id = li.id
        LEFT JOIN
    enumeration_value level ON level.id = ao.level_id
        LEFT JOIN
    enumeration_value lang ON lang.id = ao.language_id
        LEFT JOIN
    repository repo ON r.repo_id = repo.id
        LEFT JOIN
    extent e ON ao.id = e.archival_object_id
        LEFT JOIN
    enumeration_value ev ON e.extent_type_id = ev.id
        LEFT JOIN
    note ON note.archival_object_id = ao.id
            LEFT JOIN
    instance i ON i.archival_object_id = ao.id
        LEFT JOIN
    enumeration_value itype ON i.instance_type_id = itype.id
        LEFT JOIN
    sub_container sc ON sc.instance_id = i.id
        LEFT JOIN
    top_container_link_rlshp tclr ON tclr.sub_container_id = sc.id
        LEFT JOIN
    top_container tc ON tc.id = tclr.top_container_id
        LEFT JOIN
    top_container_profile_rlshp tcpr ON tc.id = tcpr.top_container_id
        LEFT JOIN
    container_profile cp ON cp.id = tcpr.container_profile_id
        LEFT JOIN
    top_container_housed_at_rlshp tchar ON tc.id = tchar.top_container_id
        LEFT JOIN
    location l ON l.id = tchar.location_id
WHERE
    ao.user_mtime > ('2016-01-20 15:00:00');