while getopts ":hc:l:t:d:" opt; do
  case ${opt} in
    h )
      echo " "
      echo "Usage: cmd-clone.sh -c /dev/sda -l /mnt -t user@192.168.x.x -d  /home/$USER/"
      echo " "
      echo "Cloning tool - clone an entire disk into an .img file"
      echo " " 
      echo "Optional Arguments:"
      echo " " 
      echo " -h    Display this help message."
      echo " -c    Select the disk to clone, e.g. /dev/sda "
      echo " -l    Select the location to mount disk, e.g. /mnt"
      echo " -t    Select a destination to transfer the clone, such as QEMU host, e.g user@192.168.x.x"
      echo " -d    Select the directory to put the clone on the QEMU host, e.g /home/$USER/"
      echo " "
      exit 0
      ;;
    c )
      clone=$OPTARG
      ;;
    l )
      location=$OPTARG
      ;;
    t )
      transfer=$OPTARG
      ;;
    d )
      directory=$OPTARG
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
    sleep 1.5
    echo "Transfering $location/disk.img to $transfer:$directory..."
    echo " "
    echo " "
    scp $location/disk.img $transfer:$directory
    if [ $? -eq 0]; then
	echo " "
	echo "disk.img successfully transfered to $transfer:$directory"
	echo " "
    else
	echo " "
	echo "disk.img unsuccesfully transfered to $transfer:$directory, Parametres were possibly wrong, try a manual scp"
	echo " " 
    fi
fi




