-- Working copy of clusters within SD, Precinct

DROP TABLE IF EXISTS working_copy_of_jamaa_cluster_id_within_sd_and_precinct_va;
CREATE TABLE working_copy_of_jamaa_cluster_id_within_sd_and_precinct_va
AS (
    SELECT *
    FROM jamaa_va_cluster_id_within_sd_and_precinct_va AS t
    WHERE t.cluster_id != '-1'
);

ALTER TABLE working_copy_of_jamaa_cluster_id_within_sd_and_precinct_va
    DROP COLUMN IF EXISTS contained_voters,
    ADD COLUMN contained_voters INT DEFAULT 0;


UPDATE working_copy_of_jamaa_cluster_id_within_sd_and_precinct_va AS wc
SET  contained_voters = sq.contained_voters
FROM (SELECT COUNT(*) AS contained_voters,
             wc.cluster_id AS cluster_id
      FROM jamaa_va_export_clustering jvm,
           working_copy_of_jamaa_cluster_id_within_sd_and_precinct_va wc
      WHERE ST_CONTAINS(wc.geom, jvm.geom)
        AND jvm.age > 50
        AND TRIM(jvm.racename) = 'African-American'
      GROUP BY wc.cluster_id) AS sq
WHERE wc.cluster_id = sq.cluster_id;

-- Add a containing SLDU field

ALTER TABLE working_copy_of_jamaa_cluster_id_within_sd_and_precinct_va
    DROP COLUMN IF EXISTS containing_sldu,
    ADD COLUMN containing_sldu TEXT DEFAULT NULL;

UPDATE working_copy_of_jamaa_cluster_id_within_sd_and_precinct_va AS wc
SET containing_sldu = sq.namelsad
FROM
(SELECT sldu.namelsad, wc.cluster_id
FROM tl_2019_51_sldu AS sldu, working_copy_of_jamaa_cluster_id_within_sd_and_precinct_va AS wc
WHERE ST_INTERSECTS(sldu.geom, wc.geom)
GROUP BY sldu.namelsad, wc.cluster_id) AS sq
WHERE wc.cluster_id = sq.cluster_id;

-- Create an aggregated SLDU table showing the sum of at risk voters

CREATE TABLE va_aggregated_cluster_counts_aggregated_to_sd AS
(SELECT sldu.namelsad,
       wc.contained_voters,
       sldu.geom
FROM
tl_2019_51_sldu AS sldu, working_copy_of_jamaa_cluster_id_within_sd_and_precinct_va AS wc
WHERE sldu.namelsad = wc.containing_sldu);