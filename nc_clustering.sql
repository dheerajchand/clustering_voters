/* STEP 1: Preparing the points table
   a. Duplicate the points table into a table that you can edit so that you maintain original data
   b. Create a geometry column for the voters (points) table
   c. Populate the geometry column in the native projection
   d. Update the geometry column to use the same projection as the Census Files
   e. Add a spatial index to the table

 */
-- 1a
DROP TABLE IF EXISTS collective_nc_export_clustering;

-- 1b
CREATE TABLE collective_nc_export_clustering
AS (SELECT vannc.*
    FROM revised_nc_for_clustering AS vannc
    WHERE UPPER(vannc.state) = 'NC');

ALTER TABLE
    collective_nc_export_clustering
    ADD COLUMN IF NOT EXISTS geom GEOMETRY(Point, 4326);

-- 1c
UPDATE
    collective_nc_export_clustering
SET geom=ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);

-- 1d

ALTER TABLE collective_nc_export_clustering
    ALTER COLUMN geom TYPE GEOMETRY(Point, 4269) USING ST_Transform(geom, 4269);

-- 1e

DROP INDEX IF EXISTS
    collective_nc_export_clustering_sdx;
CREATE INDEX
    collective_nc_export_clustering_sdx
    ON
        collective_nc_export_clustering
            USING GIST (geom);


/* STEP 2: Filter out the voters who are in the wrong state, but keep them. This can be done for other geographies.
    a. Alter the voters table to add a column for whether the labeled state matches the spatially matched state.
    b. Update the state match column with a spatial query
    c. Reproject the points table into a projection that uses meters for distance (https://epsg.io/3968)

 */

--2a

ALTER TABLE collective_nc_export_clustering
    DROP COLUMN IF EXISTS hd_label_spatial_matches,
    DROP COLUMN IF EXISTS sd_label_spatial_matches,
    DROP COLUMN IF EXISTS cd_label_spatial_matches,
    DROP COLUMN IF EXISTS county_label_spatial_matches,
    DROP COLUMN IF EXISTS state_label_spatial_matches,
    ADD COLUMN hd_label_spatial_matches     BOOLEAN DEFAULT TRUE,
    ADD COLUMN sd_label_spatial_matches     BOOLEAN DEFAULT TRUE,
    ADD COLUMN cd_label_spatial_matches     BOOLEAN DEFAULT TRUE,
    ADD COLUMN county_label_spatial_matches BOOLEAN DEFAULT TRUE,
    ADD COLUMN state_label_spatial_matches  BOOLEAN DEFAULT TRUE;

-- 2b

-- SLDL

UPDATE collective_nc_export_clustering AS c
SET hd_label_spatial_matches = ST_CONTAINS(sldl.geom, c.geom)
FROM tl_2019_37_sldl AS sldl
WHERE sldl.statefp = '37'
  AND LPAD(c.hd::TEXT, 3, '0') = sldl.sldlst;

SELECT
       c.hd,
       COUNT(c.*) AS total_voters,
       COUNT(c.*) FILTER (WHERE c.hd_label_spatial_matches = 't') AS sldl_matches,
       COUNT(c.*) FILTER (WHERE c.hd_label_spatial_matches = 'f') AS sldl_does_not_match,
       COUNT(c.*) FILTER (WHERE c.hd_label_spatial_matches NOT IN ('t','f')) AS sldl_wtf
FROM
     collective_nc_export_clustering AS c
GROUP BY c.hd
ORDER BY c.hd ASC;

-- SLDU

UPDATE collective_nc_export_clustering AS c
SET sd_label_spatial_matches = ST_CONTAINS(sldu.geom, c.geom)
FROM tl_2019_37_sldu AS sldu
WHERE sldu.statefp = '37'
  AND LPAD(c.sd::TEXT, 3, '0') = sldu.sldust;

SELECT
       c.sd,
       COUNT(c.*) AS total_voters,
       COUNT(c.*) FILTER (WHERE c.sd_label_spatial_matches = 't') AS sd_matches,
       COUNT(c.*) FILTER (WHERE c.sd_label_spatial_matches = 'f') AS sd_does_not_match,
       COUNT(c.*) FILTER (WHERE c.sd_label_spatial_matches NOT IN ('t','f')) AS sd_wtf
FROM
     collective_nc_export_clustering AS c
GROUP BY c.sd
ORDER BY c.sd ASC;



-- CD

UPDATE collective_nc_export_clustering AS c
SET cd_label_spatial_matches = ST_CONTAINS(cd.geom, c.geom)
FROM tl_2019_us_cd116 AS cd
WHERE cd.statefp = '37'
  AND LPAD({c.cd::TEXT, 2, '0') = (CASE WHEN cd.cd116fp = '00' THEN '01' ELSE cd.cd116fp END);

SELECT
       c.cd,
       COUNT(c.*) AS total_voters,
       COUNT(c.*) FILTER (WHERE c.cd_label_spatial_matches = 't') AS cd_matches,
       COUNT(c.*) FILTER (WHERE c.cd_label_spatial_matches = 'f') AS cd_does_not_match,
       COUNT(c.*) FILTER (WHERE c.cd_label_spatial_matches NOT IN ('t','f')) AS cd_wtf
FROM
     collective_nc_export_clustering AS c
GROUP BY c.cd
ORDER BY c.cd ASC;


-- COUNTY

UPDATE collective_nc_export_clustering AS c
SET county_label_spatial_matches = ST_CONTAINS(county.geom, c.geom)
FROM tl_2019_us_county AS county
WHERE county.statefp = '37'
    AND c.countyname = county.name;

SELECT
       c.countyname,
       COUNT(c.*) AS total_voters,
       COUNT(c.*) FILTER (WHERE c.county_label_spatial_matches = 't') AS countyname_matches,
       COUNT(c.*) FILTER (WHERE c.county_label_spatial_matches = 'f') AS countyname_does_not_match,
       COUNT(c.*) FILTER (WHERE c.county_label_spatial_matches NOT IN ('t','f')) AS countyname_wtf
FROM
     collective_nc_export_clustering AS c
GROUP BY c.countyname
ORDER BY c.countyname ASC;


-- STATE
UPDATE collective_nc_export_clustering AS c
SET state_label_spatial_matches = 't'
FROM tl_2019_us_state AS state
WHERE TRIM(c.state) = TRIM(state.stusps)
AND ST_CONTAINS(state.geom, c.geom);

SELECT
       c.state,
       COUNT(c.*) AS total_voters,
       COUNT(c.*) FILTER (WHERE c.county_label_spatial_matches = 't') AS state_matches,
       COUNT(c.*) FILTER (WHERE c.county_label_spatial_matches = 'f') AS state_does_not_match,
       COUNT(c.*) FILTER (WHERE c.county_label_spatial_matches NOT IN ('t','f')) AS state_wtf
FROM
     collective_nc_export_clustering AS c
GROUP BY c.state
ORDER BY c.state ASC;





ALTER TABLE collective_nc_export_clustering
    ALTER COLUMN geom TYPE GEOMETRY(Point, 32119) USING ST_Transform(geom, 32119);

DROP INDEX IF EXISTS
    collective_nc_export_clustering_sdx;
CREATE INDEX
    collective_nc_export_clustering_sdx
    ON
        collective_nc_export_clustering
            USING GIST (geom);


/* STEP 3. Create a clustering using DBSCAN

    a. Delete rows with values outside the state
    b. Create a targets column based on vote history
    c. Add a column for cluster_id
    d. Execute DBSCAN using CLUSTERWITHIN
    e. Create a geometry index for the table - tablename_sdx
 */

-- 3a

DELETE
FROM collective_nc_export_clustering AS cnec
WHERE cnec.state_label_spatial_matches = FALSE;

ALTER TABLE collective_nc_export_clustering
    DROP COLUMN IF EXISTS cluster_id,
    ADD COLUMN IF NOT EXISTS cluster_id NUMERIC DEFAULT NULL;

-- 3d

-- This DBSCAN says you need three people together within 20 meters of each other

UPDATE jamaa_va_export_clustering AS jvm
SET cluster_id =
        CASE
            WHEN sq.cluster_id > -1
                THEN sq.cluster_id
            ELSE
                -1
            END

FROM (SELECT jvm.vanid,
             ST_ClusterDBSCAN(jvm.geom, eps := 20, minPoints := 5)
             OVER (ORDER BY jvm.vanid) AS cluster_id
      FROM jamaa_va_export_clustering AS jvm
      WHERE TRIM(jvm.racename) = 'African-American'
        AND jvm.age > 50
     ) AS sq
WHERE jvm.vanid = sq.vanid;

-- But statewide clustering is not very useful - we wind up with so many clusters that
-- we have to start partitioning by smaller geographies to make this useful

/* Step 4: Add clustering within smaller geographies (CD, SD, HD)
    a. Add necessary columns
    b. Execute the queries
 */

-- 4a

SELECT cnec.cluster_id,
       COUNT(cnec.*)
FROM collective_nc_export_clustering cnec
GROUP BY cnec.cluster_id;

ALTER TABLE jamaa_va_export_clustering
    DROP COLUMN IF EXISTS cluster_id_within_cd,
    ADD COLUMN IF NOT EXISTS cluster_id_within_cd TEXT DEFAULT '-1';

ALTER TABLE jamaa_va_export_clustering
    DROP COLUMN IF EXISTS cluster_id_within_sd,
    ADD COLUMN IF NOT EXISTS cluster_id_within_sd TEXT DEFAULT '-1';

ALTER TABLE jamaa_va_export_clustering
    DROP COLUMN IF EXISTS cluster_id_within_hd,
    ADD COLUMN IF NOT EXISTS cluster_id_within_hd TEXT DEFAULT '-1';

-- 4b

-- DBSCAN within CD

UPDATE jamaa_va_export_clustering AS jvm
SET cluster_id_within_cd = CASE
                               WHEN sq.cluster_id_within_cd IS NOT NULL
                                   THEN
                                       jvm.cd || '-' || jvm.precinctname || '-' || sq.cluster_id_within_cd::TEXT
                               ELSE '-1'
    END
FROM (SELECT jvm.vanid,
             ST_ClusterDBSCAN(jvm.geom, eps := 20, minPoints := 5)
             OVER (PARTITION BY jvm.cd ORDER BY jvm.vanid) AS cluster_id_within_cd
      FROM jamaa_va_export_clustering AS jvm
      WHERE TRIM(jvm.racename) = 'African-American'
        AND jvm.age > 50
     ) AS sq
WHERE jvm.vanid = sq.vanid;

-- -- make this easier for boundary estimation later by not having NULL
--
-- UPDATE jamaa_va_export_clustering AS jvm
-- SET cluster_id_within_cd = -1
-- WHERE jvm.cluster_id_within_cd IS NULL;

-- DBSCAN within SD

UPDATE jamaa_va_export_clustering AS jvm
SET cluster_id_within_sd = CASE
                               WHEN sq.cluster_id_within_sd IS NOT NULL
                                   THEN
                                       jvm.sd || '-' || jvm.precinctname || '-' || sq.cluster_id_within_sd::TEXT
                               ELSE '-1'
    END
FROM (SELECT jvm.vanid,
             ST_ClusterDBSCAN(jvm.geom, eps := 20, minPoints := 5)
             OVER (PARTITION BY jvm.sd ORDER BY jvm.vanid) AS cluster_id_within_sd
      FROM jamaa_va_export_clustering AS jvm
      WHERE TRIM(jvm.racename) = 'African-American'
        AND jvm.age > 50
     ) AS sq
WHERE jvm.vanid = sq.vanid;

-- make this easier for boundary estimation later by not having NULL

-- UPDATE jamaa_va_export_clustering AS jvm
-- SET cluster_id_within_sd = -1
-- WHERE jvm.cluster_id_within_sd IS NULL;


-- DBSCAN WITHIN HD

UPDATE jamaa_va_export_clustering AS jvm
SET cluster_id_within_hd = CASE
                               WHEN sq.cluster_id_within_hd IS NOT NULL
                                   THEN
                                       jvm.hd || '-' || jvm.precinctname || '-' || sq.cluster_id_within_hd::TEXT
                               ELSE '-1'
    END
FROM (SELECT jvm.vanid,
             ST_ClusterDBSCAN(jvm.geom, eps := 20, minPoints := 5)
             OVER (PARTITION BY jvm.hd ORDER BY jvm.vanid) AS cluster_id_within_hd
      FROM jamaa_va_export_clustering AS jvm
      WHERE TRIM(jvm.racename) = 'African-American'
        AND jvm.age > 50
     ) AS sq
WHERE jvm.vanid = sq.vanid;

-- UPDATE jamaa_va_export_clustering AS jvm
-- SET cluster_id_within_hd = -1
-- WHERE jvm.cluster_id_within_hd IS NULL;

-- DBSCAN by precinct Within CD


/* Even those smaller geographies aren't very useful, but precincts within them could be.
   a. Add columns for cluster id's within smaller geogrpahies, precincts
   b. Do a DBScan for each
 */

-- 5a

ALTER TABLE jamaa_va_export_clustering
    DROP COLUMN IF EXISTS cluster_id_within_cd_and_precinct,
    ADD COLUMN IF NOT EXISTS cluster_id_within_cd_and_precinct TEXT DEFAULT '-1';

ALTER TABLE jamaa_va_export_clustering
    DROP COLUMN IF EXISTS cluster_id_within_sd_and_precinct,
    ADD COLUMN IF NOT EXISTS cluster_id_within_sd_and_precinct TEXT DEFAULT '-1';

ALTER TABLE jamaa_va_export_clustering
    DROP COLUMN IF EXISTS cluster_id_within_hd_and_precinct,
    ADD COLUMN IF NOT EXISTS cluster_id_within_hd_and_precinct TEXT DEFAULT '-1';


-- 5b

-- DBSCAN within CD and Precinct

UPDATE jamaa_va_export_clustering AS jvm
SET cluster_id_within_cd_and_precinct = CASE
                                            WHEN sq.cluster_id_within_cd_and_precinct IS NOT NULL
                                                THEN
                                                    jvm.hd || '-' || jvm.precinctname || '-' ||
                                                    sq.cluster_id_within_cd_and_precinct::TEXT
                                            ELSE '-1'
    END
FROM (SELECT jvm.vanid,
             ST_ClusterDBSCAN(jvm.geom, eps := 20, minPoints := 5)
             OVER (PARTITION BY jvm.cd, jvm.precinctname ORDER BY jvm.vanid) AS cluster_id_within_cd_and_precinct
      FROM jamaa_va_export_clustering AS jvm
      WHERE TRIM(jvm.racename) = 'African-American'
        AND jvm.age > 50
     ) AS sq
WHERE jvm.vanid = sq.vanid;

-- UPDATE jamaa_va_export_clustering AS jvm
-- SET cluster_id_within_cd_and_precinct = -1
-- WHERE jvm.cluster_id_within_cd_and_precinct IS NULL;

-- DBSCAN within SD and Precinct

UPDATE jamaa_va_export_clustering AS jvm
SET cluster_id_within_sd_and_precinct = CASE
                                            WHEN sq.cluster_id_within_sd_and_precinct IS NOT NULL
                                                THEN
                                                    jvm.hd || '-' || jvm.precinctname || '-' ||
                                                    sq.cluster_id_within_sd_and_precinct::TEXT
                                            ELSE '-1'
    END
FROM (SELECT jvm.vanid,
             ST_ClusterDBSCAN(jvm.geom, eps := 20, minPoints := 5)
             OVER (PARTITION BY jvm.sd, jvm.precinctname ORDER BY jvm.vanid) AS cluster_id_within_sd_and_precinct
      FROM jamaa_va_export_clustering AS jvm
      WHERE TRIM(jvm.racename) = 'African-American'
        AND jvm.age > 50
     ) AS sq
WHERE jvm.vanid = sq.vanid;

-- UPDATE jamaa_va_export_clustering AS jvm
-- SET cluster_id_within_sd_and_precinct = -1
-- WHERE jvm.cluster_id_within_sd_and_precinct IS NULL;

-- DBSCAN WITHIN HD and Precinct

UPDATE jamaa_va_export_clustering AS jvm
SET cluster_id_within_hd_and_precinct = CASE
                                            WHEN sq.cluster_id_within_hd_and_precinct IS NOT NULL
                                                THEN
                                                    jvm.hd || '-' || jvm.precinctname || '-' ||
                                                    sq.cluster_id_within_hd_and_precinct::TEXT
                                            ELSE '-1'
    END
FROM (SELECT jvm.vanid,
             ST_ClusterDBSCAN(jvm.geom, eps := 20, minPoints := 5)
             OVER (PARTITION BY jvm.hd, jvm.precinctname ORDER BY jvm.vanid) AS cluster_id_within_hd_and_precinct
      FROM jamaa_va_export_clustering AS jvm
      WHERE TRIM(jvm.racename) = 'African-American'
        AND jvm.age > 50
     ) AS sq
WHERE jvm.vanid = sq.vanid;
-- UPDATE jamaa_va_export_clustering AS jvm
-- SET cluster_id_within_hd_and_precinct = -1
-- WHERE jvm.cluster_id_within_hd_and_precinct IS NULL;

/*
 Step 6: Create distinct tables for each dataset of clusters. This is really bad boundary estimation because
 convex_hull is not parsimonious. You will get something that holds all the points, but it will contain a lot of
 extra space. Put another way, if you use convex_hull to get the boundaries of [A,B,C,D], A will contain parts of
 [B..D], etc.

 This is here for people who can't get boundary estimation from me.

    a. CD & Precinct
    b. SD & Precinct
    c. HD & Precinct
 */

-- 6a

DROP TABLE IF EXISTS jamaa_export_clustering_cd_and_precinct;

CREATE TABLE jamaa_export_clustering_cd_and_precinct AS (
    SELECT ROW_NUMBER() OVER ()                as gid,
           jvm.cluster_id_within_cd_and_precinct,
           st_convexhull(st_collect(jvm.geom)) AS geom

    FROM jamaa_va_export_clustering AS jvm
    WHERE jvm.cluster_id_within_cd_and_precinct != '-1'
    GROUP BY jvm.cluster_id_within_cd_and_precinct
);

-- 6b

DROP TABLE IF EXISTS jamaa_export_clustering_sd_and_precinct;

CREATE TABLE jamaa_export_clustering_sd_and_precinct AS (
    SELECT ROW_NUMBER() OVER ()                as gid,
           jvm.cluster_id_within_sd_and_precinct,
           st_convexhull(st_collect(jvm.geom)) AS geom

    FROM jamaa_va_export_clustering AS jvm
    WHERE jvm.cluster_id_within_sd_and_precinct != '-1'
    GROUP BY jvm.cluster_id_within_sd_and_precinct
);


-- 6c

DROP TABLE IF EXISTS jamaa_export_clustering_hd_and_precinct;

CREATE TABLE jamaa_export_clustering_hd_and_precinct AS (
    SELECT ROW_NUMBER() OVER ()                as gid,
           jvm.cluster_id_within_hd_and_precinct,
           st_convexhull(st_collect(jvm.geom)) AS geom

    FROM jamaa_va_export_clustering AS jvm
    WHERE jvm.cluster_id_within_hd_and_precinct != '-1'
    GROUP BY jvm.cluster_id_within_hd_and_precinct
);





