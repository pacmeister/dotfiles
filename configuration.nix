{ config, pkgs, ... }:

{
    imports = [ ./hardware-configuration.nix ./extra_services.nix ];
    networking.extraHosts = builtins.readFile ./hosts;


    hardware.cpu.intel.updateMicrocode = true;
    hardware.pulseaudio.enable = true;

    sound.enable = true;

    virtualisation.libvirtd.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_latest_hardened;
    boot.kernelModules = [ "fuse" "kvm-intel" "coretemp" ];
    boot.supportedFilesystems = [ "ext4" ];

    boot.loader = {
        timeout = 0;
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
    networking.hostName = "nyx";
    networking.nameservers = [ "1.1.1.1" ];
    networking.networkmanager.enable = true;

    console.font = "Lat2-Terminus16";
    console.keyMap = "us";
    i18n.defaultLocale = "en_US.UTF-8";

    time.timeZone = "US/Eastern";

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        ahoviewer bash binutils chromium cmatrix cmus conda cryfs
        cryptsetup deadbeef devilspie2 efibootmgr exa gcc gdb gforth ghc git
        gnome3.file-roller gnumake gnupg gptfdisk handbrake htop imagemagick
        kdialog keepassxc kvm libreoffice-fresh lolcat lsof lua mpv neofetch
        neovim openssh p7zip pandoc pinta pv qemu qpdfview R scrot sxhkd
        texlive.combined.scheme-small tmux transmission-gtk unrar unzip
        usbutils virtmanager vivaldi vivaldi-ffmpeg-codecs vivaldi-widevine
        weechat xclip xfce.thunar xfce.thunar-archive-plugin xfce.thunar-volman
        xorg.xhost zip zsh ripgrep
        (import ./st.nix)
    ];

    fonts.fonts = with pkgs; [
        iosevka
    ];

    programs.bash.enableCompletion = true;
    programs.zsh.enableCompletion = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    systemd.extraConfig = ''DefaultTimeoutStopSec=10s'';

    #services.printing.drivers = [ pkgs.brgenml1cupswrapper ];
    services.printing.enable = true;
    services.fstrim.enable = true;
    services.compton.enable = true;
    services.compton.shadow = true;
    services.compton.inactiveOpacity = "0.8";

    services.xserver = {
        desktopManager.gnome3.enable = true;
        #displayManager.startx.enable = true;
        displayManager.gdm.enable = true;
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

    system.stateVersion = "20.03";
    system.autoUpgrade.enable = true;
}
