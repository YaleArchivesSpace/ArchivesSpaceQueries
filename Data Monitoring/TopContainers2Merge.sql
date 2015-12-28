SELECT DISTINCT
    b.repoID, b.resource, b.indicator, b.barcode, b.tcid
FROM
    (SELECT 
        r.repo_id AS repoID,
            r.id AS resource,
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
    INNER JOIN resource r ON ao.root_record_id = r.id
    GROUP BY tc.indicator , tc.barcode , r.id
    HAVING COUNT(DISTINCT tc.id) > 1) AS a
        JOIN
    (SELECT 
        r.repo_id AS repoID,
            r.id AS resource,
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
ORDER BY b.repoID , b.resource , b.indicator