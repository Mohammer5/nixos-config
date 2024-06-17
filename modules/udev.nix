_: {
    services.udev.extraRules = ''
      # Ledger live
      # ===========

      # HW.1, Nano
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1b7c|2b7c|3b7c|4b7c", TAG+="uaccess", TAG+="udev-acl"
      # Blue, NanoS, Aramis, HW.2, Nano X, NanoSP, Stax, Ledger Test,
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", TAG+="uaccess", TAG+="udev-acl"
      # Same, but with hidraw-based library (instead of libusb)
      KERNEL=="hidraw*", ATTRS{idVendor}=="2c97", MODE="0666"

      # ZSA Keyboards
      # ============

      # Rule for all ZSA keyboards
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
      # Rule for the Moonlander
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
    '';
}
