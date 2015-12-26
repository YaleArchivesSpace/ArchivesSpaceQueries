SELECT 
    *
FROM
    resource
    join user_defined on resource.id = user_defined.resource_id
WHERE
    resource_id IS NOT NULL
        AND string_2 IS NULL;