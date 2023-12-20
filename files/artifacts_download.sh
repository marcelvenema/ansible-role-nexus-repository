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

