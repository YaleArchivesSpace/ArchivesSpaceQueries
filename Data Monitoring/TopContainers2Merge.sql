-- This isn't right yet. I'm having a hard time figuring out how get duplicates of containers that share the same barcode and indicator and are associated with the same resource.
SELECT DISTINCT
    tc.indicator, tc.barcode, r.id AS resource
FROM
    top_container tc
        INNER JOIN
    top_container_link_rlshp top_to_sub ON tc.id = top_to_sub.top_container_id
        INNER JOIN
    sub_container sc ON sc.id = top_to_sub.sub_container_id
        INNER JOIN
    instance i ON i.id = sc.instance_id
        INNER JOIN
    archival_object ao ON i.archival_object_id = ao.id
        INNER JOIN
    resource r ON ao.root_record_id = r.id
GROUP BY tc.indicator , tc.barcode , r.id
HAVING COUNT(tc.id) > 1
