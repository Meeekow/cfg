# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "arabella"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  
  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.meredith = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      kitty
      qbittorrent
      unzip
      vlc
      wget
      xclip
    ];
    initialPassword = "pass";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # My Config

  # Boot
  boot.loader.timeout = 10;
  boot.loader.systemd-boot.configurationLimit = 5;

  # Chipset
  hardware.cpu.amd.updateMicrocode = true;

  # Networking
  networking.networkmanager.insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

  # Enable mounting of NTFS
  boot.supportedFilesystems = [ "ntfs" ];

  # Gnome DE
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Exclude some packages from Gnome
  environment.gnome.excludePackages = (with pkgs; [
    gnome-console
    gnome.gnome-calendar
    baobab
    epiphany
    evince
    gnome-connections
    gnome-photos
    gnome-text-editor
    gnome-tour
    gnome.cheese
    gnome.eog
    gnome.file-roller
    gnome.geary
    gnome.gnome-characters
    gnome.gnome-clocks
    gnome.gnome-contacts
    gnome.gnome-disk-utility
    gnome.gnome-font-viewer
    gnome.gnome-logs
    gnome.gnome-maps
    gnome.gnome-music
    gnome.gnome-system-monitor
    gnome.gnome-terminal
    gnome.gnome-weather
    gnome.seahorse
    gnome.simple-scan
    gnome.totem
    gnome.yelp
  ]);

  # Exclude some packages that comes with Gnome DE
  services.xserver.excludePackages = (with pkgs; [
    xterm
  ]);

  # Bash
  programs.bash.shellAliases = {
    l = "ls -ahl --color=tty";
    v = "nvim";
    nv = "sudo nvim";
    cls = "history -c && history -w";
    mkdir = "mkdir -p";

    gs = "git status";
  };

  # Nvidia
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  # Neovim
  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        set tabstop=4 softtabstop=4 shiftwidth=4
        set expandtab smarttab autoindent
        set number
        set relativenumber
        set clipboard=unnamed,unnamedplus
        set encoding=utf-8
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ vim-nix ];
      };
    };
  };

}

