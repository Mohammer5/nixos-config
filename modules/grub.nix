{ ... }:
{
  boot.loader.grub = {
    useOSProber = false;
    extraEntries = ''
      menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-0C8F-BA08' {
        insmod part_gpt
        insmod fat
        search --no-floppy --fs-uuid --set=root 0C8F-BA08
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }

      menuentry 'Arch Linux (on /dev/nvme0n1p5)' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-simple-377d8e06-8816-4698-9231-9f6ea4ddcc5d' {
        insmod part_gpt
        insmod fat
        search --no-floppy --fs-uuid --set=root CF88-57C7
        linux /vmlinuz-linux root=UUID=377d8e06-8816-4698-9231-9f6ea4ddcc5d rw loglevel=3 quiet
        initrd /amd-ucode.img /boot/initramfs-linux.img
      }

      submenu 'Advanced options for Arch Linux (on /dev/nvme0n1p5)' $menuentry_id_option 'osprober-gnulinux-advanced-377d8e06-8816-4698-9231-9f6ea4ddcc5d' {
        menuentry 'Arch Linux (on /dev/nvme0n1p5)' --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-/vmlinuz-linux--377d8e06-8816-4698-9231-9f6ea4ddcc5d' {
          insmod part_gpt
          insmod fat
          search --no-floppy --fs-uuid --set=root CF88-57C7
          linux /vmlinuz-linux root=UUID=377d8e06-8816-4698-9231-9f6ea4ddcc5d rw loglevel=3 quiet
          initrd /amd-ucode.img /boot/initramfs-linux.img
        }
        menuentry 'Arch Linux, with Linux linux (on /dev/nvme0n1p5)' --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-/vmlinuz-linux--377d8e06-8816-4698-9231-9f6ea4ddcc5d' {
          insmod part_gpt
          insmod fat
          search --no-floppy --fs-uuid --set=root CF88-57C7
          linux /vmlinuz-linux root=UUID=377d8e06-8816-4698-9231-9f6ea4ddcc5d rw loglevel=3 quiet
          initrd /amd-ucode.img /boot/initramfs-linux.img
        }
        menuentry 'Arch Linux, with Linux linux (fallback initramfs) (on /dev/nvme0n1p5)' --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-/vmlinuz-linux--377d8e06-8816-4698-9231-9f6ea4ddcc5d' {
          insmod part_gpt
          insmod fat
          search --no-floppy --fs-uuid --set=root CF88-57C7
          linux /vmlinuz-linux root=UUID=377d8e06-8816-4698-9231-9f6ea4ddcc5d rw loglevel=3 quiet
          initrd /amd-ucode.img /boot/initramfs-linux-fallback.img
        }
      }
    '';
  };
}
