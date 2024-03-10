{ config, pkgs,  ... }:
{
  #Important system setup
  imports = [ ./hardware-configuration.nix ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #To fix libstdc++ problem for jupyter


  #network setup
  networking.hostName = "shakarisviewerofcarnage";
  networking.networkmanager.enable = true;

  #Time and location setup
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  #Desktop Setup
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  #I/O and Driver Setup
  services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.xserver.libinput.enable = true;

  #User Setup
  users.users.saturnfulcrum = {
    isNormalUser = true;
    description = "Shakari Wade";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      thunderbird
      keepassxc
      libreoffice
    ];
  };

  #Packages Setup
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    #vim-gtk
    flatpak
    distrobox
    podman
    htop
    neofetch
    ranger
    w3m
    links2
    hardinfo
    qtcreator
    glade
    tmux
    openssl_3_1
    libgccjit
    rustc
    cargo
    python3Full
    python311Packages.cython_3
    python311Packages.pip
    python311Packages.virtualenv
    jupyter-all
    go
    luajit_openresty
    jdk21
    perl
    nodejs_21
    ruby
    R
    mysql80
    dgraph
    gnome.gnome-tweaks
  ];
  #let 
  #  nixvim = import (builtins.fetchGit {
  #    url = "https://github.com/nix-community/nixvim";
  #    ref = "nixos-23.05";
  #  });
  #in
  #{
  #  imports = [ nixvim.nixosModules.nixvim ];
  #  programs.nixvim.enable = true;
  #}
  
  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #Services and Daemon Setup
  # services.openssh.enable = true;
  services.flatpak.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];


  #Notes:
}
