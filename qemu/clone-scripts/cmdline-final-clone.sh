while getopts ":hc:l:" opt; do
  case ${opt} in
    h )
      echo " "
      echo "Usage: clone.sh -c /dev/sda -l /mnt/"
      echo " "
      echo "Cloning tool - clone an entire disk into an .img file"
      echo " " 
      echo "Optional Arguments:"
      echo " " 
      echo " -h    Display this help message."
      echo " -c    Select the disk to clone, e.g. /dev/sda "
      echo " -l    Select the location to mount disk, e.g. /mnt"
      echo " "
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

echo " "
echo "You are cloning $clone into $location"
echo " "
echo "Cloning in progress..."
echo " "

dd if=$clone of=$location/disk.img status=none


echo " "
echo " "
echo "$clone successfully cloned into $locationdisk.img" 
echo " "
echo " "
