/*
 Step 0: Fix the stupid columns for the VAN imports


 */

-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:Cath" TO "2016:cath";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:ChldPrsnt" TO "2016:chldprsnt";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:ClgFndng" TO "2016:clgfndng";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:CmpgnFnc" TO "2016:cmpgnfnc";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:Evang" TO "2016:evang";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:GvPrvcy" TO "2016:gvprvcy";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:IncRnk" TO "2016:incrnk";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:MnWg" TO "2016:mnwg";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:Mrrg" TO "2016:mrrg";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:NonChrst" TO "2016:nonchrst";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:OthChrst" TO "2016:othchrst";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:PdLv" TO "2016:pdlv";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "2016:TSM:TeaPa" TO "2016:tsm:teapa";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Age" TO age;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "AptNo" TO aptno;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "AptType" TO apttype;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Autho" TO autho;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "BidenSup" TO bidensup;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "CanLeg" TO canleg;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Cell Phone" TO cell_phone;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "City" TO city;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "ClmChng" TO clmchng;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "CollGrd" TO collgrd;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Comp" TO comp;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Cosmo" TO cosmo;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "CountyName" TO countyname;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "CrimJustRef" TO crimjustref;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "DateReg" TO datereg;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Diplomacy" TO diplomacy;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "EarlyVotTim" TO earlyvottim;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "EarlyVote" TO earlyvote;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "EcoPop" TO ecopop;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Env" TO env;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "EthNat" TO ethnat;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "FirstName" TO firstname;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "FrTrd" TO frtrd;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General00" TO general00;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General01" TO general01;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General02" TO general02;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General03" TO general03;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General04" TO general04;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General05" TO general05;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General06" TO general06;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General07" TO general07;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General08" TO general08;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General09" TO general09;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General10" TO general10;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General11" TO general11;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General12" TO general12;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General14" TO general14;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General16" TO general16;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General18" TO general18;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "General19" TO general19;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Glbl" TO glbl;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Guns" TO guns;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "HCWmn" TO hcwmn;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "HSOnly" TO hsonly;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Home Phone" TO home_phone;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Ideo" TO ideo;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Imm" TO imm;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "IncInequ" TO incinequ;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Infrastruct" TO infrastruct;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "InstTrst" TO insttrst;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Jewish" TO jewish;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "LastName" TO lastname;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Latitude" TO latitude;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "LocVo" TO locvo;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Longitude" TO longitude;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "MarEqu" TO marequ;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "MediaMarketName" TO mediamarketname;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "MidGenTO" TO midgento;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "MidGenTOEnth" TO midgentoenth;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "MiddleName" TO middlename;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Mili" TO mili;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Mormon" TO mormon;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "MuniPrimary13" TO muniprimary13;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "MuniPrimary13Party" TO muniprimary13party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "MuniPrimary15" TO muniprimary15;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "MuniPrimary15Party" TO muniprimary15party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "MuniPrimary17" TO muniprimary17;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "MuniPrimary17Party" TO muniprimary17party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "MuniRunoff17" TO munirunoff17;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal00" TO municipal00;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal01" TO municipal01;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal02" TO municipal02;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal03" TO municipal03;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal04" TO municipal04;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal05" TO municipal05;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal06" TO municipal06;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal07" TO municipal07;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal08" TO municipal08;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal09" TO municipal09;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal10" TO municipal10;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal11" TO municipal11;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal12" TO municipal12;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal13" TO municipal13;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal15" TO municipal15;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal17" TO municipal17;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Municipal19" TO municipal19;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "NonPresPriTO" TO nonpresprito;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "NonRelig" TO nonrelig;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "OffGenTO" TO offgento;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "PollingAddress" TO pollingaddress;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "PollingCity" TO pollingcity;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Poor" TO poor;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Popu" TO popu;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "PrChc" TO prchc;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "PrecinctName" TO precinctname;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Preferred Phone" TO preferred_phone;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Pres" TO pres;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "PresGenTO" TO presgento;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "PresGenTOEnth" TO presgentoenth;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "PresPriTO" TO presprito;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "PresPrimary00" TO presprimary00;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "PresPrimary08" TO presprimary08;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary00" TO primary00;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary01" TO primary01;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary01Party" TO primary01party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary02" TO primary02;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary03" TO primary03;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary03Party" TO primary03party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary04" TO primary04;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary05" TO primary05;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary05Party" TO primary05party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary06" TO primary06;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary07" TO primary07;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary07Party" TO primary07party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary08" TO primary08;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary09" TO primary09;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary09Party" TO primary09party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary10" TO primary10;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary11" TO primary11;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary11Party" TO primary11party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary12" TO primary12;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary12Party" TO primary12party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary14" TO primary14;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary14Party" TO primary14party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary16" TO primary16;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary16Party" TO primary16party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary18" TO primary18;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary18Party" TO primary18party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary19" TO primary19;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary20" TO primary20;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Primary20Party" TO primary20party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "ProgTax" TO progtax;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "PthCit" TO pthcit;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "RacRes" TO racres;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "RaceName" TO racename;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "RecSens" TO recsens;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Reg" TO reg;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "RelFrdm" TO relfrdm;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "SchoolBoard13" TO schoolboard13;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "SchoolBoard17" TO schoolboard17;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Sex" TO sex;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Special19" TO special19;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "SpecialPrimary16" TO specialprimary16;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "SpecialPrimary16Party" TO specialprimary16party;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "SpecialPrimary19" TO specialprimary19;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "State" TO state;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "StreetName" TO streetname;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "StreetNo" TO streetno;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "StreetNoHalf" TO streetnohalf;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "StreetPrefix" TO streetprefix;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "StreetSuffix" TO streetsuffix;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "StreetType" TO streettype;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Suffix" TO suffix;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "TSM:Part" TO "tsm:part";
-- ALTER TABLE public.revised_nc_for_clustering RENAME "TSMAct" TO tsmact;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "TSMGnCntrl" TO tsmgncntrl;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "TSMGun" TO tsmgun;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "TSMTrumpResist" TO tsmtrumpresist;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "TSMTrumpSup" TO tsmtrumpsup;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "TSMVet" TO tsmvet;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "TSM_Ideo_Enh" TO tsm_ideo_enh;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Tax" TO tax;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Trad" TO trad;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "TrumpDef" TO trumpdef;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "UnionSupport" TO unionsupport;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Urb" TO urb;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "VendorID" TO vendorid;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Voter File VANID" TO voter_file_vanid;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "WorCl" TO worcl;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Zip4" TO zip4;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "Zip5" TO zip5;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "mAddress" TO maddress;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "mCity" TO mcity;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "mState" TO mstate;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "mZip4" TO mzip4;
-- ALTER TABLE public.revised_nc_for_clustering RENAME "mZip5" TO mzip5;


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

/*
https://www.census.gov/geographies/mapping-files/2019/dec/rdo/116-congressional-district-bef.html
Census assigns ZZ or ZZZ to no district assigned land areas, like lakes. This will likely never show up in a voter file because all voters live in districts.
01 to 53—Congressional district codes
00—At large (single district for state)
98—Nonvoting delegate
*/


-- 2b

-- SLDL

-- UPDATE collective_nc_export_clustering AS c
-- SET hd_label_spatial_matches = ST_CONTAINS(sldl.geom, c.geom)
-- FROM tl_2019_37_sldl AS sldl
-- WHERE sldl.statefp = '37'
--   AND c.sd::INT = sldl.sldlst::INT;
-- --
-- SELECT
--        c.hd,
--        COUNT(c.*) AS total_voters,
--        COUNT(c.*) FILTER (WHERE c.hd_label_spatial_matches = 't') AS sldl_matches,
--        COUNT(c.*) FILTER (WHERE c.hd_label_spatial_matches = 'f') AS sldl_does_not_match,
--        COUNT(c.*) FILTER (WHERE c.hd_label_spatial_matches NOT IN ('t','f')) AS sldl_wtf
-- FROM
--      collective_nc_export_clustering AS c
-- GROUP BY c.hd
-- ORDER BY c.hd ASC;

-- SLDU

-- UPDATE collective_nc_export_clustering AS c
-- SET sd_label_spatial_matches = ST_CONTAINS(sldu.geom, c.geom)
-- FROM tl_2019_37_sldu AS sldu
-- WHERE sldu.statefp = '37'
--   AND LPAD(c.sd::TEXT, 3, '0') = sldu.sldust;
--
-- SELECT
--        c.sd,
--        COUNT(c.*) AS total_voters,
--        COUNT(c.*) FILTER (WHERE c.sd_label_spatial_matches = 't') AS sd_matches,
--        COUNT(c.*) FILTER (WHERE c.sd_label_spatial_matches = 'f') AS sd_does_not_match,
--        COUNT(c.*) FILTER (WHERE c.sd_label_spatial_matches NOT IN ('t','f')) AS sd_wtf
-- FROM
--      collective_nc_export_clustering AS c
-- GROUP BY c.sd
-- ORDER BY c.sd ASC;



-- CD

-- UPDATE collective_nc_export_clustering AS c
-- SET cd_label_spatial_matches = ST_CONTAINS(cd.geom, c.geom)
-- FROM tl_2019_us_cd116 AS cd
-- WHERE cd.statefp = '37'
--   AND LPAD(c.cd::TEXT, 2, '0') = (CASE WHEN cd.cd116fp = '00' THEN '01' ELSE cd.cd116fp END);
--
-- SELECT
--        c.cd,
--        COUNT(c.*) AS total_voters,
--        COUNT(c.*) FILTER (WHERE c.cd_label_spatial_matches = 't') AS cd_matches,
--        COUNT(c.*) FILTER (WHERE c.cd_label_spatial_matches = 'f') AS cd_does_not_match,
--        COUNT(c.*) FILTER (WHERE c.cd_label_spatial_matches NOT IN ('t','f')) AS cd_wtf
-- FROM
--      collective_nc_export_clustering AS c
-- GROUP BY c.cd
-- ORDER BY c.cd ASC;


-- COUNTY

-- UPDATE collective_nc_export_clustering AS c
-- SET county_label_spatial_matches = ST_CONTAINS(county.geom, c.geom)
-- FROM tl_2019_us_county AS county
-- WHERE county.statefp = '37'
--     AND c.countyname = county.name;
--
-- SELECT
--        c.countyname,
--        COUNT(c.*) AS total_voters,
--        COUNT(c.*) FILTER (WHERE c.county_label_spatial_matches = 't') AS countyname_matches,
--        COUNT(c.*) FILTER (WHERE c.county_label_spatial_matches = 'f') AS countyname_does_not_match,
--        COUNT(c.*) FILTER (WHERE c.county_label_spatial_matches NOT IN ('t','f')) AS countyname_wtf
-- FROM
--      collective_nc_export_clustering AS c
-- GROUP BY c.countyname
-- ORDER BY c.countyname ASC;
--

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
--
-- DELETE
-- FROM collective_nc_export_clustering AS cnec
-- WHERE cnec.state_label_spatial_matches = FALSE;

ALTER TABLE collective_nc_export_clustering
    DROP COLUMN IF EXISTS cluster_id,
    ADD COLUMN IF NOT EXISTS cluster_id NUMERIC DEFAULT -1;

ALTER TABLE collective_nc_export_clustering
    DROP COLUMN IF EXISTS targeted_voter,
    ADD COLUMN IF NOT EXISTS targeted_voter BOOLEAN DEFAULT FALSE;

UPDATE collective_nc_export_clustering AS C
SET targeted_voter = 't'
WHERE
      c.age::NUMERIC >= 22
      AND
      c.racename = 'African-American'
      AND
      (c.general16 IS NULL OR c.general16 = 'f');

/*
 WHERE NOT (a, b) IS NULL AND NOT (c, d) IS NOT NULL

 this can set targets with more concise syntax at the expense of computation time

SELECT *
FROM revised_nc_for_clustering rc
WHERE 'did vote' = ANY(ARRAY[primary20, primary19])
    AND 'did not vote' = ANY(ARRAY[primary18, primary16])

https://dbfiddle.uk/?rdbms=postgres_12&fiddle=8c1ba8185b992c84034787e9bddd46fc
 */

-- 3d

-- This DBSCAN says you need three people together within 20 meters of each other

UPDATE collective_nc_export_clustering AS cnec
SET cluster_id =
        CASE
            WHEN sq.cluster_id > -1
                THEN sq.cluster_id
            WHEN sq.cluster_id IS NULL
                THEN -1
            ELSE
                -1
            END

FROM (SELECT cnec.voter_file_vanid,
             ST_ClusterDBSCAN(cnec.geom, eps := 20, minPoints := 3)
             OVER (ORDER BY cnec.voter_file_vanid) AS cluster_id
      FROM collective_nc_export_clustering AS cnec
      WHERE cnec.targeted_voter = 't'
     ) AS sq
WHERE cnec.voter_file_vanid = sq.voter_file_vanid;

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
GROUP BY cnec.cluster_id
ORDER BY cnec.cluster_id ASC;

ALTER TABLE collective_nc_export_clustering
    DROP COLUMN IF EXISTS cluster_id_within_cd,
    ADD COLUMN IF NOT EXISTS cluster_id_within_cd TEXT DEFAULT '-1';

ALTER TABLE collective_nc_export_clustering
    DROP COLUMN IF EXISTS cluster_id_within_sd,
    ADD COLUMN IF NOT EXISTS cluster_id_within_sd TEXT DEFAULT '-1';

ALTER TABLE collective_nc_export_clustering
    DROP COLUMN IF EXISTS cluster_id_within_hd,
    ADD COLUMN IF NOT EXISTS cluster_id_within_hd TEXT DEFAULT '-1';

-- 4b

-- DBSCAN within CD

UPDATE collective_nc_export_clustering AS cnec
SET cluster_id_within_cd = CASE
                               WHEN sq.cluster_id_within_cd IS NOT NULL
                                   THEN
                                       cnec.cd || '-' || sq.cluster_id_within_cd::TEXT
                               ELSE '-1'
    END
FROM (SELECT cnec.voter_file_vanid,
             ST_ClusterDBSCAN(cnec.geom, eps := 20, minPoints := 3)
             OVER (PARTITION BY cnec.cd ORDER BY cnec.voter_file_vanid) AS cluster_id_within_cd
      FROM collective_nc_export_clustering AS cnec
      WHERE cnec.targeted_voter = 't'
     ) AS sq
WHERE cnec.voter_file_vanid = sq.voter_file_vanid;

-- DBSCAN within SD


UPDATE collective_nc_export_clustering AS cnec
SET cluster_id_within_sd = CASE
                               WHEN sq.cluster_id_within_sd IS NOT NULL
                                   THEN
                                       cnec.sd || '-' || sq.cluster_id_within_sd::TEXT
                               ELSE '-1'
    END
FROM (SELECT cnec.voter_file_vanid,
             ST_ClusterDBSCAN(cnec.geom, eps := 20, minPoints := 3)
             OVER (PARTITION BY cnec.sd ORDER BY cnec.voter_file_vanid) AS cluster_id_within_sd
      FROM collective_nc_export_clustering AS cnec
      WHERE cnec.targeted_voter = 't'
     ) AS sq
WHERE cnec.voter_file_vanid = sq.voter_file_vanid;


UPDATE collective_nc_export_clustering AS cnec
SET cluster_id_within_hd = CASE
                               WHEN sq.cluster_id_within_hd IS NOT NULL
                                   THEN
                                       cnec.hd || '-' || sq.cluster_id_within_hd::TEXT
                               ELSE '-1'
    END
FROM (SELECT cnec.voter_file_vanid,
             ST_ClusterDBSCAN(cnec.geom, eps := 20, minPoints := 3)
             OVER (PARTITION BY cnec.hd ORDER BY cnec.voter_file_vanid) AS cluster_id_within_hd
      FROM collective_nc_export_clustering AS cnec
      WHERE cnec.targeted_voter = 't'
     ) AS sq
WHERE cnec.voter_file_vanid = sq.voter_file_vanid;

-- DBSCAN by precinct Within CD


/* Even those smaller geographies aren't very useful, but precincts within them could be.
   a. Add columns for cluster id's within smaller geogrpahies, precincts
   b. Do a DBScan for each
 */

-- 5a

ALTER TABLE collective_nc_export_clustering
    DROP COLUMN IF EXISTS cluster_id_within_cd_and_precinct,
    ADD COLUMN IF NOT EXISTS cluster_id_within_cd_and_precinct TEXT DEFAULT '-1';

ALTER TABLE collective_nc_export_clustering
    DROP COLUMN IF EXISTS cluster_id_within_sd_and_precinct,
    ADD COLUMN IF NOT EXISTS cluster_id_within_sd_and_precinct TEXT DEFAULT '-1';

ALTER TABLE collective_nc_export_clustering
    DROP COLUMN IF EXISTS cluster_id_within_hd_and_precinct,
    ADD COLUMN IF NOT EXISTS cluster_id_within_hd_and_precinct TEXT DEFAULT '-1';


-- 5b

-- DBSCAN within CD and Precinct

UPDATE collective_nc_export_clustering AS cnec
SET cluster_id_within_cd_and_precinct = CASE
                                            WHEN sq.cluster_id_within_cd_and_precinct IS NOT NULL
                                                THEN
                                                    cnec.cd || '-' || cnec.precinctname || '-' ||
                                                    sq.cluster_id_within_cd_and_precinct::TEXT
                                            ELSE '-1'
    END
FROM (SELECT cnec.voter_file_vanid,
             ST_ClusterDBSCAN(cnec.geom, eps := 20, minPoints := 3)
             OVER (PARTITION BY cnec.cd, cnec.precinctname ORDER BY cnec.voter_file_vanid) AS cluster_id_within_cd_and_precinct
      FROM collective_nc_export_clustering AS cnec
      WHERE cnec.targeted_voter = 't'
     ) AS sq
WHERE cnec.voter_file_vanid = sq.voter_file_vanid;

-- DBSCAN within SD and Precinct

UPDATE collective_nc_export_clustering AS cnec
SET cluster_id_within_sd_and_precinct = CASE
                                            WHEN sq.cluster_id_within_sd_and_precinct IS NOT NULL
                                                THEN
                                                    cnec.sd || '-' || cnec.precinctname || '-' ||
                                                    sq.cluster_id_within_sd_and_precinct::TEXT
                                            ELSE '-1'
    END
FROM (SELECT cnec.voter_file_vanid,
             ST_ClusterDBSCAN(cnec.geom, eps := 20, minPoints := 3)
             OVER (PARTITION BY cnec.sd, cnec.precinctname ORDER BY cnec.voter_file_vanid) AS cluster_id_within_sd_and_precinct
      FROM collective_nc_export_clustering AS cnec
      WHERE cnec.targeted_voter = 't'
     ) AS sq
WHERE cnec.voter_file_vanid = sq.voter_file_vanid;

-- DBSCAN WITHIN HD and Precinct

UPDATE collective_nc_export_clustering AS cnec
SET cluster_id_within_hd_and_precinct = CASE
                                            WHEN sq.cluster_id_within_hd_and_precinct IS NOT NULL
                                                THEN
                                                    cnec.hd || '-' || cnec.precinctname || '-' ||
                                                    sq.cluster_id_within_hd_and_precinct::TEXT
                                            ELSE '-1'
    END
FROM (SELECT cnec.voter_file_vanid,
             ST_ClusterDBSCAN(cnec.geom, eps := 20, minPoints := 3)
             OVER (PARTITION BY cnec.hd, cnec.precinctname ORDER BY cnec.voter_file_vanid) AS cluster_id_within_hd_and_precinct
      FROM collective_nc_export_clustering AS cnec
      WHERE cnec.targeted_voter = 't'
     ) AS sq
WHERE cnec.voter_file_vanid = sq.voter_file_vanid;

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

-- -- 6a
--
-- DROP TABLE IF EXISTS jamaa_export_clustering_cd_and_precinct;
--
-- CREATE TABLE jamaa_export_clustering_cd_and_precinct AS (
--     SELECT ROW_NUMBER() OVER ()                as gid,
--            jvm.cluster_id_within_cd_and_precinct,
--            st_convexhull(st_collect(jvm.geom)) AS geom
--
--     FROM jamaa_va_export_clustering AS jvm
--     WHERE jvm.cluster_id_within_cd_and_precinct != '-1'
--     GROUP BY jvm.cluster_id_within_cd_and_precinct
-- );
--
-- -- 6b
--
-- DROP TABLE IF EXISTS jamaa_export_clustering_sd_and_precinct;
--
-- CREATE TABLE jamaa_export_clustering_sd_and_precinct AS (
--     SELECT ROW_NUMBER() OVER ()                as gid,
--            jvm.cluster_id_within_sd_and_precinct,
--            st_convexhull(st_collect(jvm.geom)) AS geom
--
--     FROM jamaa_va_export_clustering AS jvm
--     WHERE jvm.cluster_id_within_sd_and_precinct != '-1'
--     GROUP BY jvm.cluster_id_within_sd_and_precinct
-- );
--
--
-- -- 6c
--
-- DROP TABLE IF EXISTS jamaa_export_clustering_hd_and_precinct;
--
-- CREATE TABLE jamaa_export_clustering_hd_and_precinct AS (
--     SELECT ROW_NUMBER() OVER ()                as gid,
--            jvm.cluster_id_within_hd_and_precinct,
--            st_convexhull(st_collect(jvm.geom)) AS geom
--
--     FROM jamaa_va_export_clustering AS jvm
--     WHERE jvm.cluster_id_within_hd_and_precinct != '-1'
--     GROUP BY jvm.cluster_id_within_hd_and_precinct
-- );


