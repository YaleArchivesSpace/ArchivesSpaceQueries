USE schema;
SELECT 
    note.resource_id, cast(note.notes AS CHAR(10000) CHARACTER SET utf8)
FROM
    note
        JOIN
    resource ON resource.id = note.resource_id
WHERE
    (resource_id IS NOT NULL
        OR note.archival_object_id IS NOT NULL)
        AND note.notes LIKE '%accessrestrict%'
        AND resource.repo_id = 12;
