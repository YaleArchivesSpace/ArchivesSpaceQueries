SELECT 
    *
FROM
    archival_object
WHERE
    level_id = 897
        AND NOT (component_id LIKE '%accession%'
        OR component_id LIKE '%Accession%')
        AND NOT component_id REGEXP '^[0-9.]+$'