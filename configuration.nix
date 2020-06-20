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

    i18n = {
       consoleFont = "Lat2-Terminus16";
        consoleKeyMap = "us";
        defaultLocale = "en_US.UTF-8";
    };

    time.timeZone = "US/Eastern";

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        ack ahoviewer ark bash binutils cmatrix cmus conda cryfs deadbeef
        devilspie2 efibootmgr exa zsh firejail gcc gdb gforth git
        gnumake gnupg chromium gptfdisk handbrake
        htop imagemagick kdialog keepassxc kvm libreoffice-fresh lolcat
        lsof lua mpv neofetch neovim okular openssh p7zip pandoc pinta pv
        qemu scrot stockfish cryptsetup texlive.combined.scheme-small tmux
        transmission-gtk unrar unzip usbutils virtmanager weechat xorg.xhost
        zip sxhkd ghc R 
        (import ./st.nix)
        (import ./cudatext.nix)
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

    services.xserver = {
        desktopManager.plasma5.enable = true;
        displayManager.sddm.enable = true;
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
