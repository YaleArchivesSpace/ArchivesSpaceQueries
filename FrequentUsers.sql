SELECT 
    CONCAT('accessions/', accession.id),
    accession.repo_id,
    accession.create_time,
    accession.created_by,
    accession.user_mtime,
    accession.last_modified_by
FROM
    accession
WHERE
    user_mtime > '2015-06-30' 
UNION ALL SELECT 
    CONCAT('resources/', resource.id),
    resource.repo_id,
    resource.create_time,
    resource.created_by,
    resource.user_mtime,
    resource.last_modified_by
FROM
    resource
WHERE
    user_mtime > '2015-06-30' 
UNION ALL SELECT 
    CONCAT('resources/',
            resource.id,
            '#tree::archival_object_',
            archival_object.id),
    archival_object.repo_id,
    archival_object.create_time,
    archival_object.created_by,
    archival_object.user_mtime,
    archival_object.last_modified_by
FROM
    archival_object
        JOIN
    resource ON archival_object.root_record_id = resource.id
WHERE
    archival_object.user_mtime > '2015-06-30'
