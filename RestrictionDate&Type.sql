SELECT 
    rights_restriction.resource_id,
    rights_restriction.archival_object_id,
    rights_restriction.restriction_note_type,
    rights_restriction.begin,
    rights_restriction.end,
    enumeration_value.value
FROM
    rights_restriction_type
        JOIN
    rights_restriction ON rights_restriction.id = rights_restriction_type.rights_restriction_id
        JOIN
    enumeration_value ON enumeration_value.id = rights_restriction_type.restriction_type_id
where rights_restriction.end is not null
