SELECT 
    top_container.id,
    resource.identifier,
    top_container.barcode,
    top_container.indicator,
    container_profile.name,
    container_profile.height,
    container_profile.width,
    container_profile.depth
FROM
    top_container
        JOIN
    top_container_link_rlshp ON top_container.id = top_container_link_rlshp.top_container_id
        JOIN
    top_container_profile_rlshp ON top_container.id = top_container_profile_rlshp.top_container_id
        JOIN
    container_profile ON container_profile.id = top_container_profile_rlshp.container_profile_id
        JOIN
    sub_container ON top_container_link_rlshp.sub_container_id = sub_container.id
        JOIN
    instance ON sub_container.instance_id = instance.id
        JOIN
    archival_object ON instance.archival_object_id = archival_object.id
        JOIN
    resource ON archival_object.root_record_id = resource.id
WHERE
    resource.title LIKE '%Kissinger%'
GROUP BY top_container.id;
