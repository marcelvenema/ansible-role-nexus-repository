#

# Get parameter flags
while getopts u:p:a:n:f: flag
do
    case "${flag}" in
        u) nexus_repository_username=${OPTARG};;
        p) nexus_repository_password=${OPTARG};;
        a) nexus_repository_address=${OPTARG};;
        n) nexus_repository_name=${OPTARG};;
        f) nexus_repository_artifact=${OPTARG};;
    esac
done

url=$nexus_repository_address"/service/rest/v1/assets?repository="$nexus_repository_name
cToken="initial"
while [ ! -z "$cToken" ]; do
    if [ "$cToken" != "initial" ]; then
        url=$nexus_repository_address"/service/rest/v1/assets?continuationToken="$cToken"&repository="$nexus_repository_name
    fi
    echo Processing repository token: $cToken | tee -a $logfile
    response=`curl -ksSL -u "$nexus_repository_username:$nexus_repository_password" -X GET --header 'Accept: application/json' "$url"`
    readarray -t artifacts < <( jq  '[.items[].downloadUrl]' <<< "$response" )
    printf "%s\n" "${artifacts[@]}" > artifacts.temp
    sed 's/\"//g' artifacts.temp > artifacts1.temp
    sed 's/,//g' artifacts1.temp > artifacts.temp
    sed 's/[][]//g' artifacts.temp > artifacts1.temp
    cat artifacts1.temp >> $outputFile
    cToken=( $(echo $response | sed -n 's|.*"continuationToken" : "\([^"]*\)".*|\1|p') )
done


