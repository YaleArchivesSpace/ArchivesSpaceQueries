SELECT 
    tcc.URL,
    tcc.indicator,
    tcc.barcode,
    tcc.resourceID,
    tcc.locationID,
    CONCAT('locations/', locationID) locationURL
FROM
    top_container_candidates tcc
        INNER JOIN
    (SELECT 
        Indicator, ResourceID, COUNT(DISTINCT LocationID) AS 'Count'
    FROM
        top_container_candidates_join
    GROUP BY Indicator , ResourceID
    HAVING COUNT(DISTINCT LocationID) > 1) AS grouped ON grouped.indicator = tcc.indicator
        AND grouped.resourceID = tcc.resourceID
ORDER BY resourceID , indicator , locationID;
