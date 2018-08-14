while getopts ":hc:l:" opt; do
  case ${opt} in
    h )
      echo " "
      echo "Usage: clone.sh -c /dev/sda -l /mnt"
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
echo "You are cloning $clone into $location/disk.img"
echo " "
echo " "
echo "Cloning in progress..."
echo " "
s
dd if=$clone of=$location/disk.img status=none

if [ $(blockdev --getsize64 $clone) -ne $(stat -c %s $location/disk.img) ]; then
    echo " "
    echo " "
    rm $location/disk.img
    echo "$clone unsuccessfully cloned into $location/disk.img"
    echo " "
    echo " "
else
    echo " "
    echo " "
    echo "$clone successfully cloned into $location/disk.img" 
    echo " "
    echo " "
fi




