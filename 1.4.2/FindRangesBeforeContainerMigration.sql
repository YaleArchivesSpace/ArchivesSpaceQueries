SELECT 
    resource.repo_id AS repo_id,
    resource.id AS resource_id,
    resource.identifier AS resource_identifier,
    archival_object.id AS component_id,
    container.id AS container_id,
    container.barcode_1 AS barcode,
    container.indicator_1 AS container_indicator
FROM
    container
        JOIN
    instance ON container.instance_id = instance.id
        JOIN
    archival_object ON instance.archival_object_id = archival_object.id
        JOIN
    resource ON archival_object.root_record_id = resource.id
WHERE
    container.indicator_1 LIKE '%-%'
