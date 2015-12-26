SELECT 
    'accession',
    accession.id,
    NULL,
    accession.identifier,
    accession.title
FROM
    accession
        JOIN
    date ON accession.id = date.accession_id
WHERE
    date.certainty_id IS NOT NULL 
UNION ALL SELECT 
    'resource',
    resource.id,
    NULL,
    resource.identifier,
    resource.title
FROM
    resource
        JOIN
    date ON resource.id = date.resource_id
WHERE
    date.certainty_id IS NOT NULL 
UNION ALL SELECT 
    'archival object',
    resource.id,
    archival_object.id,
    resource.identifier,
    archival_object.title
FROM
    archival_object
        JOIN
    date ON archival_object.id = date.archival_object_id
        JOIN
    resource ON resource.id = archival_object.root_record_id
WHERE
    date.certainty_id IS NOT NULL