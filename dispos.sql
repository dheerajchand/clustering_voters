/* SOME DISPOS */

-- Whether or not geocodes are good by race

SELECT
       jvm.state_label_spatial_matches,
       COUNT(jvm.*) AS total_voters
FROM jamaa_va_export_clustering jvm
GROUP BY 1;

-- Whether or not geocodes are good by race

SELECT
       COUNT(jva.state_label_spatial_matches) FILTER (WHERE jva.state_label_spatial_matches = 't') AS state_label_matches,
       COUNT(jva.state_label_spatial_matches) FILTER (WHERE jva.state_label_spatial_matches = 'f') AS state_label_does_not_match,
       jva.racename
    FROM
jamaa_va_export_clustering AS jva
GROUP BY jva.racename;

-- Counts of cluster_id ; -1 is NULL

SELECT jvm.cluster_id_within_sd_and_precinct,
       COUNT(*) AS total_voters
FROM jamaa_va_export_clustering AS jvm
WHERE jvm.cluster_id_within_sd_and_precinct != '-1'
GROUP BY 1
ORDER BY 2 DESC;