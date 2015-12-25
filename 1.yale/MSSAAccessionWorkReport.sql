SELECT 
    accession.identifier,
    accession.id,
    accession.title,
    collection_management.processors,
    collection_management.processing_started_date,
    enumeration_value.value,
    accession.user_mtime as 'last edited',
    accession.last_modified_by as 'last edited by'
FROM
    accession
        LEFT JOIN
    collection_management ON accession.id = collection_management.accession_id
        LEFT JOIN
    enumeration_value ON collection_management.processing_status_id = enumeration_value.id
WHERE
    accession.repo_id = 12
        AND (collection_management.accession_id IS NULL
        OR (collection_management.processing_status_id = 255
        OR collection_management.processing_status_id = 256))
ORDER BY processors, accession.user_mtime desc;
