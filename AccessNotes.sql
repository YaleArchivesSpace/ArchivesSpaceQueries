SELECT 
    note.resource_id,
    NULL,
    CAST(note.notes AS CHAR (10000) CHARACTER SET UTF8),
    rights_restriction.begin,
    rights_restriction.end,
    rights_restriction_type.restriction_type_id
FROM
    note
        JOIN
    resource ON resource.id = note.resource_id
        LEFT JOIN
    rights_restriction ON resource.id = rights_restriction.resource_id
        LEFT JOIN
    rights_restriction_type ON rights_restriction.id = rights_restriction_type.rights_restriction_id
WHERE
    note.notes LIKE '%accessrestrict%'
        AND resource.repo_id = 12 
UNION ALL SELECT 
    archival_object.root_record_id,
    note.archival_object_id,
    CAST(note.notes AS CHAR (10000) CHARACTER SET UTF8),
    rights_restriction.begin,
    rights_restriction.end,
    rights_restriction_type.restriction_type_id
FROM
    note
        JOIN
    archival_object ON archival_object.id = note.archival_object_id
        LEFT JOIN
    rights_restriction ON archival_object.id = rights_restriction.archival_object_id
        LEFT JOIN
    rights_restriction_type ON rights_restriction.id = rights_restriction_type.rights_restriction_id
WHERE
    note.notes LIKE '%accessrestrict%'
        AND archival_object.repo_id = 12
ORDER BY resource_id ASC;
