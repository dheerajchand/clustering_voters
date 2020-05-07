-- Let's check out the intersections of Precincts and State Senate

DROP TABLE IF EXISTS
    precinct_sldu_all_int_src;

CREATE TABLE precinct_sldu_all_int_src AS (
    SELECT ROW_NUMBER() OVER ()                                                  AS pid,
           precinct.id                                                           AS precinct_id,
           census.gid                                                            as sldu_id,
           precinct.precinctna                                                   AS precinct_name,
           census.namelsad                                                       AS sldu_name,
           precinct.geom                                                         AS precinct_geom,
           census.geom                                                           AS sldu_geom,
           ST_MULTI(ST_BUFFER(ST_INTERSECTION(precinct.geom, census.geom), 0.0)) AS intersection_geom
    FROM siege_ngpvan_estimated_precincts2020 AS precinct
             INNER JOIN tl_2019_51_sldu AS census
                        ON (ST_INTERSECTS(precinct.geom, census.geom))
    WHERE NOT ST_ISEMPTY(ST_BUFFER(ST_INTERSECTION(precinct.geom, census.geom), 0.0)));

CREATE INDEX precinct_sldu_sdx
    ON
        precinct_sldu_all_int_src
            USING GIST (intersection_geom);

DROP TABLE IF EXISTS precinct_sldu_all_int_rep;

CREATE TABLE precinct_sldu_all_int_rep AS
    (SELECT src.pid                                                     AS pid,
            src.precinct_id                                             AS precinct_id,
            src.sldu_id                                                 AS sldu_id,
            src.sldu_name || ' - ' || src.precinct_name                 AS composing_districts,
            ST_AREA(src.intersection_geom) / ST_AREA(src.precinct_geom) AS overlap_ratio_for_precinct,
            ST_AREA(src.intersection_geom) / ST_AREA(src.sldu_geom)     AS overlap_ratio_for_sldu,
            src.intersection_geom                                       AS geom
     FROM precinct_sldu_all_int_src AS src);

DROP INDEX IF EXISTS
    precinct_sldu_all_int_rep_sdx;

CREATE INDEX IF NOT EXISTS
    precinct_sldu_all_int_rep_sdx
    ON
        precinct_sldu_all_int_rep
            USING GIST (geom);

-- Let's check out the intersections of Precincts and Clusters (State Senate, Precinct)

DROP TABLE IF EXISTS
    va_precinct_cluster_all_int_src;

CREATE TABLE va_precinct_cluster_all_int_src AS (
    SELECT ROW_NUMBER() OVER ()                                                   AS pid,
           precinct.id                                                            AS precinct_id,
           cluster.id                                                             as cluster_id,
           precinct.precinctna                                                    AS precinct_name,
           cluster.cluster_id                                                     AS cluster_name,
           precinct.geom                                                          AS precinct_geom,
           cluster.geom                                                           AS cluster_geom,
           ST_MULTI(ST_BUFFER(ST_INTERSECTION(precinct.geom, cluster.geom), 0.0)) AS intersection_geom
    FROM siege_ngpvan_estimated_precincts2020 AS precinct
             INNER JOIN working_copy_of_jamaa_cluster_id_within_sd_and_precinct_va AS cluster
                        ON (ST_INTERSECTS(precinct.geom, cluster.geom))
    WHERE NOT ST_ISEMPTY(ST_BUFFER(ST_INTERSECTION(precinct.geom, cluster.geom), 0.0)));

CREATE INDEX va_precinct_cluster_all_int_sdx
    ON
        va_precinct_cluster_all_int_src
            USING GIST (intersection_geom);

DROP TABLE IF EXISTS va_precinct_cluster_all_int_rep;

CREATE TABLE va_precinct_cluster_all_int_rep AS
    (SELECT src.pid                                                     AS pid,
            src.precinct_id                                             AS precinct_id,
            src.cluster_id                                              AS cluster_id,
            src.cluster_name || ' - ' || src.precinct_name              AS composing_districts,
            ST_AREA(src.intersection_geom) / ST_AREA(src.precinct_geom) AS overlap_ratio_for_precinct,
            ST_AREA(src.intersection_geom) / ST_AREA(src.cluster_geom)  AS overlap_ratio_for_sldu,
            src.intersection_geom                                       AS geom
     FROM va_precinct_cluster_all_int_src AS src);

DROP INDEX IF EXISTS
    va_precinct_cluster_all_int_rep_sdx;

CREATE INDEX
    va_precinct_cluster_all_int_rep_sdx
    ON va_precinct_cluster_all_int_rep USING GIST (geom);