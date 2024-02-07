# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,... }:

let
  unstable = import <nixos-unstable> {config.allowUnfree=true;};
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";  
  boot.loader.systemd-boot.configurationLimit = 20;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.xserver.displayManager = {
	defaultSession = "none+i3";
  };

  services.xserver.windowManager.i3 = {
	enable=true;
  	extraPackages = with pkgs; [
		polybar
		i3lock
		rofi
		autotiling
	];
  };


  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput = {
	mouse.accelProfile = "flat";	
  };


  users.groups = { uinput = {}; };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tom = {
    isNormalUser = true;
    description = "tom";
    extraGroups = [ "networkmanager" "wheel" "uinput" "input" "audio" "video" "libvirtd" "docker" "hidraw"];
    packages = with pkgs; [
      firefox
    ];
  };

  services.udev.extraRules =
	''
	KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
	'';
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    alacritty
    (import ./onedriver.nix)
    git
    xfce.thunar
    libreoffice
    picom-jonaburg
    gparted
    keepassxc
    nodejs
    tldr
    neofetch
    networkmanagerapplet
    zsh
    ranger
    rhythmbox
    protonvpn-cli
    htop
    cmatrix
    auto-cpufreq
    brightnessctl
    xss-lock
    flitter
    appimage-run
    steam
    # unstable.osu-lazer-bin
    ifuse
    usbmuxd
    docker
    docker-compose
    via
    qmk
    tailscale
    libreddit
    gnumake
    gcc8
    python3Full
    pkgsCross.avr.buildPackages.gcc
	tlp
    zip
    unzip
    libsForQt5.kdeconnect-kde
    anki-bin
    mpv
    (import ./nix-gaming/pkgs/osu-lazer-bin/default.nix)
  ];

  virtualisation.docker.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  
  programs.kdeconnect.enable = true;
  # services.tailscale.enable = true;
  services.libreddit.enable = true;
  services.usbmuxd.enable = true;
  services.flatpak.enable = true;
  services.auto-cpufreq.enable = true;
  #services.auto-cpufreq.settings = {
  #  battery = {
  #  	governor = "powersave";
  #  	turbo = "never";
  #  };
  #};
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;
 
  programs.steam = {
	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
  }; 
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessi ons.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 8000 ];
  networking.firewall.allowedUDPPorts = [ 8080 8000 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
