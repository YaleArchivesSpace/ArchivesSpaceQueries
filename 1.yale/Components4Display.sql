SELECT 
    count(*)
FROM
    archival_object parents
    left join archival_object children
    on parents.id = children.parent_id
    LEFT JOIN
    instance ON instance.archival_object_id = parents.id
        LEFT JOIN
    sub_container ON sub_container.instance_id = instance.id
        LEFT JOIN
    top_container_link_rlshp ON top_container_link_rlshp.sub_container_id = sub_container.id
        LEFT JOIN
    top_container ON top_container.id = top_container_link_rlshp.top_container_id
    where children.id is null;
