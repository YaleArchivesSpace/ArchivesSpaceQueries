SELECT 
    resource.repo_id AS repo_id,
    resource.id AS resource_id,
    resource.identifier AS resource_identifier,
    archival_object.id AS component_id,
    top_container.id AS container_id,
    top_container.barcode,
    top_container.indicator AS top_container_indicator
FROM
    top_container
        JOIN
    top_container_link_rlshp ON top_container.id = top_container_link_rlshp.top_container_id
        JOIN
    sub_container ON top_container_link_rlshp.sub_container_id = sub_container.id
        JOIN
    instance ON sub_container.instance_id = instance.id
        JOIN
    archival_object ON instance.archival_object_id = archival_object.id
        JOIN
    resource ON archival_object.root_record_id = resource.id
WHERE
    top_container.indicator LIKE '%-%'
