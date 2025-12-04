_: {
  fileSystems."/mnt/ssd" = {
    device = "/dev/disk/by-uuid/446B37004CFC205F";
    fsType = "ntfs3";
    options = [ "rw" "nofail" "uid=1000" "gid=100" "umask=022" ];
  };
}
