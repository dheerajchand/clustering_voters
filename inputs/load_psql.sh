export PGHOST="localhost"
export PGUSER="dheerajchand"
export PGPASSWORD="dessert"
export PGPORT="54321"
export PGDATABASE="gis"

schema="public"
tabblock_projection=4269

SOURCE_DIR='./downloads'
ZIP_DIR="./unzipped"

find ./ -name '*.zip' -exec sh -c 'unzip -u -d "${1%.*}" "$1"' _ {} \;

for shapefile in $(find downloads/ -type f -name '*.shp');
 do
   tablename="$(basename "$shapefile" .shp)"
   echo $tablename
   shp2pgsql -d -I -s $tabblock_projection $shapefile $schema.$tablename| psql
 done
