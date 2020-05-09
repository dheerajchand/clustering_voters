# https://stackoverflow.com/questions/5986942/how-to-copy-all-files-via-ftp-in-rsync
# https://www.linux.com/tutorials/wget-and-downloading-entire-remote-directory/

years=( "2019" "2018" )
geographies=("CD" "TABBLOCK" "COUNTY" "SLDL" "SLDU" "STATE" "TRACT" "TTRACT" "ZCTA5" "BG" "ROADS")

LOCAL_PARENT_DIR='downloads'
APP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

DOWNLOAD_DIR=$APP_DIR/$LOCAL_PARENT_DIR

for y in "${years[@]}" # outer loop is years
do
for g in "${geographies[@]}" # inner loop is geographies
do
echo "Working on : ${y} : ${g} \n"
target_directory=$DOWNLOAD_DIR/${y}/${g}
mkdir -p $target_directory # make a receipt path for the data
url="ftp://ftp2.census.gov//geo/tiger/TIGER${y}/${g}/"
cd $target_directory
wget .zip -r -level=0 -ignore-length --no-host-directories -k -p -erobots=off -nd -c $url
done
done
