while getopts ":hc:l:" opt; do
  case ${opt} in
    h )
      echo "Usage: clone.sh -c /dev/sda -l /mnt/"    
      echo " "
      echo "Optional Arguments:"
      echo " " 
      echo " -h    Display this help message."
      echo " -c    Select the disk to clone, e.g. /dev/sda "
      echo " -l    Select the location to mount disk, e.g. /mnt"
      exit 0
      ;;
    c )
      clone=$OPTARG
      ;;
    l )
      location=$OPTARG
      ;;
    \? )
      echo "Invalid Option: -$OPTARG" 1>&2
      exit 1
      ;;
    : )
      echo "Invalid Option: -$OPTARG requires an argument" 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

echo "You are cloning $clone into $location"
echo "Cloning in progress..."
