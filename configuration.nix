{ config, pkgs, ... }:

{
    imports = [ ./hardware-configuration.nix ./extra_services.nix ];

    fileSystems."/home/pac/Dropbox" =
    {
        device = "/home/pac/dropbox.img";
        fsType = "ext4";
    };

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

    environment.systemPackages = with pkgs;
    [
    ack ahoviewer ark bash bc binutils cmatrix cmus conda cryfs deadbeef
    devilspie2 dropbox efibootmgr exa fish firejail gcc gdb gforth git gnumake
    gnupg gnuplot google-chrome gptfdisk handbrake htop imagemagick kdialog
    keepassxc kvm ldc libreoffice-fresh lolcat lsof lua lynx mpv neofetch neovim
    okular openssh p7zip pandoc pinta pv qemu rc spectacle stockfish cryptsetup
    texlive.combined.scheme-small tmux transmission-gtk unrar unzip usbutils
    virtmanager weechat xorg.xhost zip leafpad usbutils sxhkd ghc arc-theme
    (import ./st.nix)
    ];

    fonts.fonts = with pkgs;
    [
    iosevka
    ];

    programs.adb.enable = true;
    programs.bash.enableCompletion = true;
    programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

    systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
    '';
    systemd.user.services.mpd.enable = true;

    # services.printing.drivers = [ pkgs.brgenml1cupswrapper ];
    services.printing.enable = true;

    services.xserver = {
        desktopManager.plasma5.enable = true;
        displayManager.sddm.enable = true;
        videoDrivers = [ "nvidia" ];
        enable = true;
        xkbOptions = "eurosign:e";
        layout = "us";
    };

    services.postgresql.enable = true;
    services.postgresql.package = pkgs.postgresql_11;

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
