SELECT 
    accession.identifier,
    accession.display_string,
    date.expression,
    date.begin,
    date.end,
    accession.content_description,
    accession.provenance,
    extent.number,
    enumeration_value.value,
    extent.container_summary
FROM
    accession
        JOIN
    extent ON accession.id = extent.accession_id
        JOIN
    enumeration_value ON extent.extent_type_id = enumeration_value.id
        JOIN
    date ON accession.id = date.accession_id
WHERE
    accession_date > '2014-06-30' -- change to represent new fiscal year
        AND accession_date < '2015-07-01' -- change to represent new fiscal year
        AND repo_id = 12;
