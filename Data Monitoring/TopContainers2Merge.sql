SELECT DISTINCT
    b.repoID, b.resource, b.indicator, b.barcode, b.tcid
FROM
    (SELECT 
        resource.repo_id AS repoID,
            top_container.id AS tcid,
            CONCAT('repo', resource.repo_id, 'resource', resource.id, 'box', top_container.indicator, COALESCE(top_container.barcode, '')) AS container
    FROM
        top_container
    INNER JOIN top_container_link_rlshp ON top_container.id = top_container_link_rlshp.top_container_id
    INNER JOIN sub_container ON sub_container.id = top_container_link_rlshp.sub_container_id
    INNER JOIN instance ON instance.id = sub_container.instance_id
    INNER JOIN archival_object ON instance.archival_object_id = archival_object.id
    INNER JOIN resource ON archival_object.root_record_id = resource.id
    GROUP BY top_container.indicator , top_container.barcode , resource.id
    HAVING COUNT(DISTINCT top_container.id) > 1) a
        JOIN
    (SELECT 
        r.repo_id AS repoID,
        r.id as resource,
            tc.id AS tcid,
            CONCAT('repo', r.repo_id, 'resource', r.id, 'box', tc.indicator, COALESCE(tc.barcode, '')) AS container,
            tc.indicator AS indicator,
            tc.barcode AS barcode
    FROM
        top_container tc
    INNER JOIN top_container_link_rlshp top_to_sub ON tc.id = top_to_sub.top_container_id
    INNER JOIN sub_container sc ON sc.id = top_to_sub.sub_container_id
    INNER JOIN instance i ON i.id = sc.instance_id
    INNER JOIN archival_object ao ON i.archival_object_id = ao.id
    INNER JOIN resource r ON ao.root_record_id = r.id) AS b ON a.container = b.container
ORDER BY b.repoID, b.resource, b.indicator