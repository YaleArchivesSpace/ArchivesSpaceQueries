SELECT 
    resource.repo_id, resource_id, COUNT(*)
FROM
    ProdTest.subject_rlshp
        JOIN
    resource ON resource.id = subject_rlshp.resource_id
GROUP BY resource_id
ORDER BY COUNT(*) DESC
LIMIT 50;
SELECT 
    resource.repo_id, resource_id, COUNT(*)
FROM
    ProdTest.linked_agents_rlshp
        JOIN
    resource ON resource.id = linked_agents_rlshp.resource_id
GROUP BY resource_id
ORDER BY COUNT(*) DESC
LIMIT 50;
