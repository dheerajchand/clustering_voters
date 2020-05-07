-- working copy of estimated precincts

DROP TABLE IF EXISTS working_copy_of_siege_va_precincts;
CREATE TABLE working_copy_of_siege_va_precincts
AS (
    SELECT *
    FROM siege_ngpvan_estimated_precincts2020 AS t
);

ALTER TABLE working_copy_of_siege_va_precincts
    DROP COLUMN IF EXISTS contained_voters,
    ADD COLUMN contained_voters INT DEFAULT 0;


UPDATE working_copy_of_siege_va_precincts AS wc
SET  contained_voters = sq.contained_voters
FROM (SELECT COUNT(*) AS contained_voters,
             wc.precinctna AS precinctna
      FROM jamaa_va_export_clustering jvm,
           working_copy_of_siege_va_precincts wc
      WHERE ST_CONTAINS(wc.geom, jvm.geom)
        AND jvm.age > 50
        AND TRIM(jvm.racename) = 'African-American'
      GROUP BY wc.precinctna) AS sq
WHERE wc.precinctna = sq.precinctna;

-- working copy of cluster and precinct intersections

DROP TABLE IF EXISTS working_copy_of_va_precinct_cluster_all_int_rep;
CREATE TABLE working_copy_of_va_precinct_cluster_all_int_rep
AS (
    SELECT *
    FROM va_precinct_cluster_all_int_rep
);

ALTER TABLE working_copy_of_va_precinct_cluster_all_int_rep
    DROP COLUMN IF EXISTS contained_voters,
    ADD COLUMN contained_voters INT DEFAULT 0;

UPDATE working_copy_of_va_precinct_cluster_all_int_rep AS wc
SET contained_voters = sq.contained_voters
FROM
(SELECT COUNT(*) AS contained_voters,
        wc.pid
    FROM jamaa_va_export_clustering AS jvm,
         working_copy_of_va_precinct_cluster_all_int_rep AS wc
    WHERE ST_CONTAINS(wc.geom, jvm.geom)
    AND jvm.age > 50
    AND TRIM(jvm.racename) = 'African-American'
    GROUP BY wc.pid) AS sq
WHERE wc.pid = sq.pid;