-- CREATE va voters from massive file and geographize

DROP TABLE IF EXISTS va_voters;

CREATE TABLE va_voters AS
    (SELECT *
     FROM combined_csv AS ccsv
     WHERE UPPER(ccsv.vb_vf_reg_cass_state) = 'VA');

ALTER TABLE
    va_voters
    ADD COLUMN IF NOT EXISTS geom GEOMETRY(Point, 4326);

-- 1c
UPDATE
    va_voters
SET geom=ST_SetSRID(ST_MakePoint(vb_reg_longitude, vb_reg_latitude), 4326);

-- 1d

ALTER TABLE va_voters
    ALTER COLUMN geom TYPE GEOMETRY(Point, 4269) USING ST_Transform(geom, 4269);

-- 1e

CREATE INDEX
    va_voters_sdx
    ON
        va_voters
            USING GIST (geom);


-- CREATE precincts geom for va
DROP TABLE IF EXISTS
    va_precinct_box;

CREATE TABLE va_precinct_box AS (

    SELECT * FROM (
                      SELECT vav.vb_vf_national_precinct_code AS precinct,
                             COUNT(vav.geom)                  AS count_of_geoms,
                             ST_MULTI(st_extent(vav.geom))    AS geom
                      FROM va_voters AS vav
                      WHERE vav.geom IS NOT NULL
                      AND vav.vb_vf_national_precinct_code IS NOT NULL
                      AND LENGTH(vav.vb_vf_national_precinct_code) > 0
                      GROUP BY vav.vb_vf_national_precinct_code
                  ) AS subquery
    WHERE
    NOT st_isempty(subquery.geom)
    AND subquery.geom IS NOT NULL
    AND LOWER(subquery.precinct) != 'nan'
    AND subquery.precinct IS NOT NULL
    AND length(subquery.precinct) > 0

    ORDER BY ST_AREA(subquery.geom) DESC
        );


    
