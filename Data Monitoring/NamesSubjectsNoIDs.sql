SELECT 
    'agents/agent_person', np.id, nai.authority_id, np.sort_name
FROM
    name_authority_id nai
        RIGHT OUTER JOIN
    name_person np ON np.id = nai.name_person_id
WHERE
    nai.name_person_id IS NULL 
UNION ALL SELECT 
    'agents/agent_family', nf.id, nai.authority_id, nf.sort_name
FROM
    name_authority_id nai
        RIGHT OUTER JOIN
    name_family nf ON nf.id = nai.name_family_id
WHERE
    nai.name_family_id IS NULL 
UNION ALL SELECT 
    'agents/agent_corporate_entity',
    nc.id,
    nai.authority_id,
    nc.sort_name
FROM
    name_authority_id nai
        RIGHT OUTER JOIN
    name_corporate_entity nc ON nc.id = nai.name_corporate_entity_id
WHERE
    nai.name_corporate_entity_id IS NULL
UNION ALL SELECT 
    'subjects', s.id, s.authority_id, s.title
FROM
    subject s
WHERE
    s.authority_id IS NULL;
