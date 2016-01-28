use Prod20160120;
SELECT 
    CONCAT('/agents/agent_person/', np.id) 'agent URL',
    np.sort_name,
    rules.value rules,
    source.value source,
    ac.address_1,
    ac.address_2,
    ac.address_3,
    ac.city,
    ac.region,
    ac.country,
    ac.post_code,
    ac.email,
    np.last_modified_by,
    np.user_mtime,
    np.system_mtime
FROM
    name_person np
        LEFT JOIN
    agent_person ap ON np.agent_person_id = ap.id
        LEFT JOIN
    agent_contact ac ON ac.agent_person_id = ap.id
        LEFT JOIN
    enumeration_value rules ON rules.id = np.rules_id
        LEFT JOIN
    enumeration_value source ON source.id = np.source_id
WHERE
    np.system_mtime > ('2016-01-20 15:00:00') 
UNION ALL SELECT 
    CONCAT('/agents/agent_corporate_entity/',
            nce.id),
    nce.sort_name,
    rules.value rules,
    source.value source,
    ac.address_1,
    ac.address_2,
    ac.address_3,
    ac.city,
    ac.region,
    ac.country,
    ac.post_code,
    ac.email,
    nce.last_modified_by,
    nce.user_mtime,
    nce.system_mtime
FROM
    name_corporate_entity nce
        LEFT JOIN
    agent_corporate_entity ace ON nce.agent_corporate_entity_id = ace.id
        LEFT JOIN
    agent_contact ac ON ac.agent_corporate_entity_id = ace.id
        LEFT JOIN
    enumeration_value rules ON rules.id = nce.rules_id
        LEFT JOIN
    enumeration_value source ON source.id = nce.source_id
WHERE
    nce.system_mtime > ('2016-01-20 15:00:00') 
UNION ALL SELECT 
    CONCAT('/agents/agent_family/', nf.id),
    nf.sort_name,
    rules.value rules,
    source.value source,
    ac.address_1,
    ac.address_2,
    ac.address_3,
    ac.city,
    ac.region,
    ac.country,
    ac.post_code,
    ac.email,
    nf.last_modified_by,
    nf.user_mtime,
    nf.system_mtime
FROM
    name_family nf
        LEFT JOIN
    agent_family af ON nf.agent_family_id = af.id
        LEFT JOIN
    agent_contact ac ON ac.agent_family_id = af.id
        LEFT JOIN
    enumeration_value rules ON rules.id = nf.rules_id
        LEFT JOIN
    enumeration_value source ON source.id = nf.source_id
WHERE
    nf.system_mtime > ('2016-01-20 15:00:00')