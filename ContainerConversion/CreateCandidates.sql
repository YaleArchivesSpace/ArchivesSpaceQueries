use OldRAC;
start transaction;
create temporary table top_container_candidates
SELECT 
    CONCAT('resources/', i.resource_id) URL,
    c.indicator_1 indicator,
    c.barcode_1 barcode,
    i.resource_id resourceID,
    l.id locationID
FROM
    container c
        JOIN
    instance i ON c.instance_id = i.id
        JOIN
    resource r ON i.resource_id = r.id
        LEFT JOIN
    housed_at_rlshp har ON har.container_id = c.id
        LEFT JOIN
    location l ON har.location_id = l.id
UNION ALL SELECT 
    CONCAT('resources/',
            r.id,
            '#tree::archival_object_',
            i.archival_object_id),
    c.indicator_1 indicator,
    c.barcode_1 barcode,
    r.id,
    l.id
FROM
    container c
        JOIN
    instance i ON c.instance_id = i.id
        JOIN
    archival_object ao ON i.archival_object_id = ao.id
        JOIN
    resource r ON r.id = ao.root_record_id
        LEFT JOIN
    housed_at_rlshp har ON har.container_id = c.id
        LEFT JOIN
    location l ON har.location_id = l.id
UNION ALL SELECT 
    CONCAT('accessions/', i.accession_id),
    c.indicator_1 ,
    c.barcode_1 ,
    NULL,
    l.id
FROM
    container c
        JOIN
    instance i ON c.instance_id = i.id
        JOIN
    accession a ON i.accession_id = a.id
        LEFT JOIN
    housed_at_rlshp har ON har.container_id = c.id
        LEFT JOIN
    location l ON har.location_id = l.id;
    commit;
    start transaction;
create temporary table top_container_candidates_join
SELECT 
    CONCAT('resources/', i.resource_id) URL,
    c.indicator_1 indicator,
    c.barcode_1 barcode,
    i.resource_id resourceID,
    l.id locationID
FROM
    container c
        JOIN
    instance i ON c.instance_id = i.id
        JOIN
    resource r ON i.resource_id = r.id
        LEFT JOIN
    housed_at_rlshp har ON har.container_id = c.id
        LEFT JOIN
    location l ON har.location_id = l.id
UNION ALL SELECT 
    CONCAT('resources/',
            r.id,
            '#tree::archival_object_',
            i.archival_object_id),
    c.indicator_1 indicator,
    c.barcode_1 barcode,
    r.id,
    l.id
FROM
    container c
        JOIN
    instance i ON c.instance_id = i.id
        JOIN
    archival_object ao ON i.archival_object_id = ao.id
        JOIN
    resource r ON r.id = ao.root_record_id
        LEFT JOIN
    housed_at_rlshp har ON har.container_id = c.id
        LEFT JOIN
    location l ON har.location_id = l.id
UNION ALL SELECT 
    CONCAT('accessions/', i.accession_id),
    c.indicator_1 ,
    c.barcode_1 ,
    NULL,
    l.id
FROM
    container c
        JOIN
    instance i ON c.instance_id = i.id
        JOIN
    accession a ON i.accession_id = a.id
        LEFT JOIN
    housed_at_rlshp har ON har.container_id = c.id
        LEFT JOIN
    location l ON har.location_id = l.id;
    commit;