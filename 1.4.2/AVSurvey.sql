use Prod20160114;
SELECT 
-- building my column set -- creating URLs that will make it easy to act on this list
    ao.id,
    CONCAT('http://prodaspace.library.yale.edu:8080/resources/',
            r.id) AS resource_URL,
    r.title AS 'resource',
    CONCAT('http://prodaspace.library.yale.edu:8080/resources/',
            r.id,
            '#tree::archival_object_',
            ao.id) AS component_URL,
    ao.display_string AS 'component',
    level.value AS level,
-- displaying the extent two different ways to allow for easy reporting and easy arithmetic
    e.number AS 'extent number',
    ev.value AS 'extent type',
    CONCAT(e.number,
            ' ',
            ev.value,
            e.container_summary) AS 'extent statement',
    itype.value AS 'instance type',
    CONCAT('http://prodaspace.library.yale.edu:8080/plugins/top_containers/',
            tc.id) AS container_URL,
-- this part of the query is for physical stuff in containers
    tc.indicator AS box,
    tc.barcode AS barcode,
    cp.name AS 'container profile',
    l.title AS location
FROM
-- this join logic was hard-won.
    archival_object ao
        LEFT JOIN
    extent e ON ao.id = e.archival_object_id
        LEFT JOIN
    enumeration_value ev ON e.extent_type_id = ev.id
        LEFT JOIN
-- the enumeration_value table is referenced from many others -- needs to be aliased for each use
    enumeration_value level ON ao.level_id = level.id
        LEFT JOIN
    resource r ON r.id = ao.root_record_id
        LEFT JOIN
    instance i ON i.archival_object_id = ao.id
        LEFT JOIN
    enumeration_value itype ON i.instance_type_id = itype.id
        LEFT JOIN
    sub_container sc ON sc.instance_id = i.id
        LEFT JOIN
    top_container_link_rlshp tclr ON tclr.sub_container_id = sc.id
        LEFT JOIN
    top_container tc ON tc.id = tclr.top_container_id
        LEFT JOIN
    top_container_profile_rlshp tcpr ON tc.id = tcpr.top_container_id
        LEFT JOIN
    container_profile cp ON cp.id = tcpr.container_profile_id
        LEFT JOIN
    top_container_housed_at_rlshp tchar ON tc.id = tchar.top_container_id
        LEFT JOIN
    location l ON l.id = tchar.location_id
WHERE
-- for this query, checking common A/V strings in component title, container profile name, and extent
    ((ao.title LIKE '%recording%'
        OR ao.title LIKE '%video%'
        OR ao.title LIKE '%audio%'
        OR ao.title LIKE '%VHS%'
-- the inclusion of "film" is going to produce false positives.
        OR ao.title LIKE '%film%'
        OR ao.title LIKE '% sound%'
        OR ao.title LIKE '%Beta%')
        OR (r.title LIKE '%recording%'
        OR r.title LIKE '%video%'
        OR r.title LIKE '%film%'
        OR r.title LIKE '%audio%'
        OR r.title LIKE '%VHS%'
        OR r.title LIKE '% sound%'
        OR r.title LIKE '%Beta%')
        OR (cp.name LIKE '%CD%'
        OR cp.name LIKE '%audio%'
        OR cp.name LIKE '%video%'
        OR cp.name LIKE '%DV%'
        OR cp.name LIKE '%film%'
        OR cp.name LIKE '%U-matic%')
        OR (e.container_summary LIKE '%recording%'
        OR e.container_summary LIKE '%video%'
        OR e.container_summary LIKE '%film%'
        OR e.container_summary LIKE '%audio%'
        OR e.container_summary LIKE '%VHS%'
        OR e.container_summary LIKE '% sound%'
        OR e.container_summary LIKE '%Beta%')
        OR (ev.value LIKE '%audiocassettes%'
        OR ev.value LIKE '%CD%'
        OR ev.value LIKE '%cassettes'
        OR ev.value LIKE '%video%'
        OR ev.value LIKE '%reel%'
        OR ev.value LIKE '%film%'
        OR ev.value LIKE '%dv%'
        OR ev.value LIKE '%film%'
        OR ev.value LIKE '%phono%'
        OR ev.value LIKE '%DV%'
        OR ev.value LIKE '%audio%'))
        AND r.repo_id = 12
        AND cp.name NOT LIKE '%microfilm%'
        AND ao.title NOT LIKE '%microfilm%'
-- instance type id 356 is for mixed materials, which distinguishes it from digital object instances
        AND i.instance_type_id = 356 
UNION ALL SELECT 
-- now we're taking the results of the previous query and finding associated digital objects
    ao.id,
    CONCAT('http://prodaspace.library.yale.edu:8080/resources/',
            r.id) AS resource_URL,
    r.title AS 'resource',
    CONCAT('http://prodaspace.library.yale.edu:8080/resources/',
            r.id,
            '#tree::archival_object_',
            ao.id) AS component_URL,
    ao.display_string AS 'component',
    level.value AS level,
    e.number AS 'extent number',
    ev.value AS 'extent type',
    CONCAT(e.number,
            ' ',
            ev.value,
            e.container_summary) AS 'extent statement',
    itype.value AS 'instance type',
    CONCAT('http://prodaspace.library.yale.edu:8080/digital_objects',
            do.id),
    NULL,
    NULL,
    NULL,
    NULL
FROM
    archival_object ao
        LEFT JOIN
    extent e ON ao.id = e.archival_object_id
        LEFT JOIN
    enumeration_value ev ON e.extent_type_id = ev.id
        LEFT JOIN
    enumeration_value level ON ao.level_id = level.id
        LEFT JOIN
    resource r ON r.id = ao.root_record_id
        LEFT JOIN
    instance i ON i.archival_object_id = ao.id
        LEFT JOIN
    enumeration_value itype ON i.instance_type_id = itype.id
        LEFT JOIN
    instance_do_link_rlshp idlr ON i.id = idlr.instance_id
        LEFT JOIN
    digital_object do ON idlr.digital_object_id = do.id
WHERE
    i.instance_type_id = 119987
        AND r.repo_id = 12
-- the subquery below is what limits these results to just digital objects associated with the components found above.
        AND ao.id IN (SELECT 
            ao.id
        FROM
            archival_object ao
                LEFT JOIN
            extent e ON ao.id = e.archival_object_id
                LEFT JOIN
            enumeration_value ev ON e.extent_type_id = ev.id
                LEFT JOIN
            enumeration_value level ON ao.level_id = level.id
                LEFT JOIN
            resource r ON r.id = ao.root_record_id
                LEFT JOIN
            instance i ON i.archival_object_id = ao.id
                LEFT JOIN
            enumeration_value itype ON i.instance_type_id = itype.id
                LEFT JOIN
            sub_container sc ON sc.instance_id = i.id
                LEFT JOIN
            top_container_link_rlshp tclr ON tclr.sub_container_id = sc.id
                LEFT JOIN
            top_container tc ON tc.id = tclr.top_container_id
                LEFT JOIN
            top_container_profile_rlshp tcpr ON tc.id = tcpr.top_container_id
                LEFT JOIN
            container_profile cp ON cp.id = tcpr.container_profile_id
                LEFT JOIN
            top_container_housed_at_rlshp tchar ON tc.id = tchar.top_container_id
                LEFT JOIN
            location l ON l.id = tchar.location_id
        WHERE
            ((ao.title LIKE '%recording%'
                OR ao.title LIKE '%video%'
                OR ao.title LIKE '%audio%'
                OR ao.title LIKE '%VHS%'
                OR ao.title LIKE '%film%'
                OR ao.title LIKE '% sound%'
                OR ao.title LIKE '%Beta%')
                OR (r.title LIKE '%recording%'
                OR r.title LIKE '%video%'
                OR r.title LIKE '%film%'
                OR r.title LIKE '%audio%'
                OR r.title LIKE '%VHS%'
                OR r.title LIKE '% sound%'
                OR r.title LIKE '%Beta%')
                OR (cp.name LIKE '%CD%'
                OR cp.name LIKE '%audio%'
                OR cp.name LIKE '%video%'
                OR cp.name LIKE '%DV%'
                OR cp.name LIKE '%film%'
                OR cp.name LIKE '%U-matic%')
                OR (e.container_summary LIKE '%recording%'
                OR e.container_summary LIKE '%video%'
                OR e.container_summary LIKE '%film%'
                OR e.container_summary LIKE '%audio%'
                OR e.container_summary LIKE '%VHS%'
                OR e.container_summary LIKE '% sound%'
                OR e.container_summary LIKE '%Beta%')
                OR (ev.value LIKE '%audiocassettes%'
                OR ev.value LIKE '%CD%'
                OR ev.value LIKE '%cassettes'
                OR ev.value LIKE '%video%'
                OR ev.value LIKE '%reel%'
                OR ev.value LIKE '%film%'
                OR ev.value LIKE '%dv%'
                OR ev.value LIKE '%film%'
                OR ev.value LIKE '%phono%'
                OR ev.value LIKE '%DV%'
                OR ev.value LIKE '%audio%'))
                AND r.repo_id = 12
                AND cp.name NOT LIKE '%microfilm%'
                AND ao.title NOT LIKE '%microfilm%'
                AND i.instance_type_id = 356);