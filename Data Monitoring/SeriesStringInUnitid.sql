SELECT 
    *
FROM
    archival_object
WHERE
    (level_id = 897 OR level_id = 900)
        AND (component_id LIKE '%Series%'
        OR component_id LIKE '%series%')
ORDER BY id DESC;