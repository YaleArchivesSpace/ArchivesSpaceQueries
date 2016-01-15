use Prod20160114;
SELECT 
    CONCAT('http://prodaspace.library.yale.edu:8080/resources/',
            r.id) AS resource_URL,
    r.title AS 'resource',
    CONCAT('http://prodaspace.library.yale.edu:8080/resources/',
            r.id,
            '#tree::archival_object_',
            ao.id) AS component_URL,
    ao.display_string AS 'component',
    level.value AS level,
    e.number AS 'extent number',
    ev.value AS 'extent type',
    CONCAT(e.number,
            ' ',
            ev.value,
            e.container_summary) AS 'extent statement',
    CONCAT('http://prodaspace.library.yale.edu:8080/plugins/top_containers/',
            tc.id) AS ContainerURL,
    tc.indicator AS box,
    tc.barcode AS barcode,
    cp.name AS 'container profile',
    l.title AS location
FROM
    archival_object ao
        LEFT JOIN
    extent e ON ao.id = e.archival_object_id
        LEFT JOIN
    enumeration_value ev ON e.extent_type_id = ev.id
        LEFT JOIN
    enumeration_value level ON ao.level_id = level.id
        LEFT JOIN
    resource r ON r.id = ao.root_record_id
        LEFT JOIN
    instance i ON i.archival_object_id = ao.id
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
    ((ao.title LIKE '%recording%'
        OR ao.title LIKE '%video%'
        OR ao.title LIKE '%audio%'
        OR ao.title LIKE '%VHS%'
        OR ao.title LIKE '%film%'
        OR ao.title LIKE '% sound%'
        OR ao.title LIKE '%Beta%')
        OR (r.title LIKE '%recording%'
        OR r.title LIKE '%video%'
        OR r.title LIKE '%film%'
        OR r.title LIKE '%audio%'
        OR r.title LIKE '%VHS%'
        OR r.title LIKE '% sound%'
        OR r.title LIKE '%Beta%')
        OR (cp.name LIKE '%CD%'
        OR cp.name LIKE '%audio%'
        OR cp.name LIKE '%video%'
        OR cp.name LIKE '%DV%'
        OR cp.name LIKE '%film%'
        OR cp.name LIKE '%U-matic%')
        OR (e.container_summary LIKE '%recording%'
        OR e.container_summary LIKE '%video%'
        OR e.container_summary LIKE '%film%'
        OR e.container_summary LIKE '%audio%'
        OR e.container_summary LIKE '%VHS%'
        OR e.container_summary LIKE '% sound%'
        OR e.container_summary LIKE '%Beta%')
        OR (ev.value LIKE '%audiocassettes%'
        OR ev.value LIKE '%CD%'
        OR ev.value LIKE '%cassettes'
        OR ev.value LIKE '%video%'
        OR ev.value LIKE '%reel%'
        OR ev.value LIKE '%film%'
        OR ev.value LIKE '%dv%'
        OR ev.value LIKE '%film%'
        OR ev.value LIKE '%phono%'
        OR ev.value LIKE '%DV%'
        OR ev.value LIKE '%audio%'))
        AND r.repo_id = 12
        AND cp.name NOT LIKE '%microfilm%'
        AND ao.title NOT LIKE '%microfilm%'
ORDER BY ao.id ASC; 