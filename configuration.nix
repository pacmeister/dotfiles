{ config, pkgs, ... }:

{
    imports = [ ./hardware-configuration.nix ./extra_services.nix ];

    hardware.cpu.intel.updateMicrocode = true;
    hardware.pulseaudio.enable = true;

    sound.enable = true;

    virtualisation.libvirtd.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_latest_hardened;
    boot.kernelModules = [ "fuse" "kvm-intel" "coretemp" ];
    boot.supportedFilesystems = [ "xfs" "ext4" ];

    boot.loader = {
        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot/";
        };
        systemd-boot = {
            configurationLimit = 4;
            enable = true;
            memtest86.enable = true;
        };
    };

    networking.firewall.allowedTCPPorts = [ 3301 ];
    networking.firewall.allowedUDPPorts = [ 3301 ];
    networking.hostName = "nixos";
    networking.nameservers = [ "1.1.1.1" ];
    networking.networkmanager.enable = true;
    networking.extraHosts = builtins.readFile ./hosts;

    i18n = {
        consoleFont = "Lat2-Terminus16";
        consoleKeyMap = "us";
        defaultLocale = "en_US.UTF-8";
    };

    time.timeZone = "US/Eastern";

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        ack ahoviewer ark bash bc binutils cmatrix cmus conda cryfs deadbeef
        devilspie2 dropbox efibootmgr exa zsh firejail gcc gdb gforth git
        gnome3.gnome-tweaks gnumake gnupg gnuplot chromium gptfdisk handbrake
        htop imagemagick kdialog keepassxc kvm ldc libreoffice-fresh lolcat
        lsof lua lynx mpv neofetch neovim okular openssh p7zip pandoc pinta pv
        qemu rc scrot stockfish cryptsetup texlive.combined.scheme-small tmux
        transmission-gtk unrar unzip usbutils virtmanager weechat xorg.xhost
        zip usbutils sxhkd ghc leafpad R (import ./st.nix)
    ];

    fonts.fonts = with pkgs; [
        iosevka
    ];

    programs.adb.enable = true;
    programs.bash.enableCompletion = true;
    programs.zsh.enableCompletion = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    systemd.extraConfig = ''DefaultTimeoutStopSec=10s'';

    #services.printing.drivers = [ pkgs.brgenml1cupswrapper ];
    services.printing.enable = true;

    services.xserver = {
        desktopManager.gnome3.enable = true;
        displayManager.gdm.enable = true;
        #displayManager.gdm.wayland = false;
        videoDrivers = [ "nvidia" ];
        enable = true;
        xkbOptions = "eurosign:e";
        layout = "us";
    };

    services.cron = {
        enable = true;
        systemCronJobs = [
            "*/5 * * * *      root    date >> /tmp/cron.log"
        ];
    };

    users.extraUsers.pac = {
        isNormalUser = true;
        home="/home/pac";
        extraGroups = [ "wheel" "networkmanager" "adbusers" "libvirt" ];
    };

    system.stateVersion = "19.09";
    system.autoUpgrade.enable = true;
}
