# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = false;
  boot.loader.grub.efiInstallAsRemovable = false;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
   boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

   networking.hostName = "nixos"; # Define your hostname.
   networking.networkmanager.enable = true;  # nmtui.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
   environment.systemPackages = with pkgs; [
     vim
   ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.layout = "us";
   #services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
   services.xserver.displayManager.sddm.enable = false;
   services.xserver.desktopManager.xfce.enable = true;


   #TODO MACHINE_SPECIFIC
   services.xserver.synaptics.enable = true;
   services.xserver.videoDrivers = ["intel" "nvidia"];
   hardware.bumblebee.enable = true;
   hardware.bumblebee.connectDisplay = false;
   nixpkgs.config.allowUnfree = true; 
   services.sshd.enable = true;
   services.xserver.displayManager.xserverArgs = [ "-logfile" "/var/log/X.log" ];
  #boot.kernelPackages = pkgs.linuxPackages_3_10;


users = {
extraGroups = [{ name = "bumblebee"; }];
};
   #Define a user account. Don't forget to set a password with ‘passwd’.
   users.extraUsers.jason = {
     isNormalUser = true;
     home = "/home/alice";
     #uid = 1000;
     extraGroups = ["wheel" "networkmanager" "bumblebee"];
   };



  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
