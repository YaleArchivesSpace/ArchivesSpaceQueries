use Prod20160120;
SELECT 
    CONCAT('/resources/', r.id) 'resource URL',
    repo.repo_code,
    r.identifier,
    r.title,
    dti.value 'date type',
    li.value 'date label',
    d.expression,
    d.begin,
    d.end,
    r.repository_processing_note,
    r.ead_id,
    r.ead_location,
    r.finding_aid_title,
    r.finding_aid_subtitle,
    r.finding_aid_filing_title,
    r.finding_aid_date,
    r.finding_aid_author,
    fadri.value 'finding aid rules',
    fasi.value 'finding aid status',
    r.created_by,
    r.create_time,
    r.last_modified_by,
    r.system_mtime
FROM
    resource r
        LEFT JOIN
    date d ON d.resource_id = r.id
        LEFT JOIN
    enumeration_value dti ON d.date_type_id = dti.id
        LEFT JOIN
    enumeration_value li ON d.label_id = li.id
        LEFT JOIN
    enumeration_value fadri ON r.finding_aid_description_rules_id = fadri.id
        LEFT JOIN
    enumeration_value fasi ON r.finding_aid_status_id = fasi.id
        LEFT JOIN
    repository repo ON r.repo_id = repo.id
WHERE
    r.user_mtime > ('2016-01-20 15:00:00');