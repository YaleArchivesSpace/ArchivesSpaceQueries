use Prod20160120;
SELECT 
    CONCAT('/accessions/', a.id) 'accession URL',
    repo.repo_code,
    a.identifier,
    a.display_string,
    a.content_description,
    a.condition_description,
    a.disposition,
    a.inventory,
    a.provenance,
    a.general_note,
    acqtype.value acquisitionType,
    a.accession_date,
    a.retention_rule,
    a.access_restrictions_note,
    a.use_restrictions_note,
    cm.processing_hours_per_foot_estimate,
    cm.processing_total_extent,
    cm.processing_hours_total,
    cm.processing_plan,
    pp.value 'processing priority',
    ps.value 'processing status',
    cm.processing_funding_source,
    cm.processors,
    eti.value 'event type',
    outcome.value 'event outcome',
    a.last_modified_by,
    a.system_mtime,
    a.created_by,
    a.create_time
FROM
    accession a
        LEFT JOIN
    collection_management cm ON cm.accession_id = a.id
        LEFT JOIN
    event_link_rlshp elr ON elr.accession_id = a.id
        LEFT JOIN
    event e ON elr.event_id = e.id
        LEFT JOIN
    enumeration_value acqtype ON a.acquisition_type_id = acqtype.id
        LEFT JOIN
    enumeration_value pp ON cm.processing_priority_id = pp.id
        LEFT JOIN
    enumeration_value ps ON cm.processing_status_id = ps.id
        LEFT JOIN
    enumeration_value eti ON e.event_type_id = eti.id
        LEFT JOIN
    enumeration_value outcome ON e.outcome_id = outcome.id
    left join 
    repository repo on a.repo_id = repo.id
WHERE
    a.user_mtime > ('2016-01-20 15:00:00')
ORDER BY a.repo_id , a.last_modified_by;