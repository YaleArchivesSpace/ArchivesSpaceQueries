SELECT 
    *
FROM
    top_container_candidates
WHERE
    barcode IS NOT NULL
        AND barcode IN (SELECT 
            barcode
        FROM
            top_container_candidates_join
        GROUP BY barcode
        HAVING COUNT(barcode) > 1
            AND COUNT(indicator) > 1)
ORDER BY barcode;