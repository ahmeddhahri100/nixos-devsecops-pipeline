# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Africa/Tunis";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ar_TN.UTF-8";
      LC_IDENTIFICATION = "ar_TN.UTF-8";
      LC_MEASUREMENT = "ar_TN.UTF-8";
      LC_MONETARY = "ar_TN.UTF-8";
      LC_NAME = "ar_TN.UTF-8";
      LC_NUMERIC = "ar_TN.UTF-8";
      LC_PAPER = "ar_TN.UTF-8";
      LC_TELEPHONE = "ar_TN.UTF-8";
      LC_TIME = "ar_TN.UTF-8";
    };
  };

  # Configure console keymap
  console.keyMap = "fr";

  services = {
    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Configure keymap in X11
    xserver.xkb = {
      layout = "fr";
      variant = "";
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;
    };

    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users."dhahri" = {
    isNormalUser = true;
    description = "dhahri";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      git
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix!
    wget
  ];

  # This option defines the first version of NixOS you have installed on this
  # particular machine, and is used to maintain compatibility with application
  # data (e.g. databases) created on older NixOS versions.
  #
  # Do NOT change this value unless you have manually inspected all the changes
  # it would make to your configuration, and migrated your data accordingly.
  system.stateVersion = "26.05"; # Did you read the comment?
}
