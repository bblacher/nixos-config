{ config, lib, pkgs, modulesPath, ... }:

{
  	imports = [ ];

  	networking = {
		hostName = "nixos-xps";
		useDHCP = lib.mkDefault true;
	};

  	time.timeZone = "Europe/Vienna";

  	i18n.defaultLocale = "en_GB.UTF-8";
  	console = {
		keyMap = lib.mkDefault "uk";
  	};

	environment.gnome.excludePackages = with pkgs; [
		orca
		evince
		# file-roller
		geary
		# gnome-disk-utility
		seahorse
		# sushi
		# sysprof
		# gnome-shell-extensions
		# adwaita-icon-theme
		# gnome-backgrounds
		# gnome-bluetooth
		# gnome-color-manager
		# gnome-control-center
		gnome-shell-extensions
		gnome-tour
		gnome-user-docs
		# glib
		# gnome-menus
		# gtk3.out
		# xdg-user-dirs
		# xdg-user-dirs-gtk
		baobab
		epiphany
		gnome-text-editor
		# gnome-calculator
		# gnome-calendar
		# gnome-characters
		# gnome-clocks
		# gnome-console
		gnome-contacts
		# gnome-font-viewer
		# gnome-logs
		gnome-maps
		gnome-music
		# gnome-system-monitor
		gnome-weather
		# loupe
		# nautilus
		gnome-connections
		simple-scan
		# snapshot
		totem
		yelp
		gnome-software
	];


  	services = {
		pipewire = {
			enable = true;
			alsa.enable = true;
			pulse.enable = true;
		};
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = true;

  	};

  	users.users.bblacher = {
    		home = "/home/bblacher";
    		isNormalUser = true;
    		extraGroups = [ "wheel" "networkmanager" ];
  	};

  	programs = {

		firefox = {
			enable = true;
			
		};
		thunderbird = {
			enable = true;
		};
		vim = {
			enable = true;
			defaultEditor = true;
		};
		nano.enable = false;
	};

	environment = {
		systemPackages = with pkgs; [
			syncthing
			
			git
			fastfetch
			texliveFull

			papers
			showtime

			rnote
			xournalpp
			element-desktop
			jellyfin-media-player
		];
		sessionVariables = rec {
			ELECTRON_OZONE_PLATFORM_HINT = "auto";
		};
	};

	fonts = {
		enableDefaultPackages = true;
		packages = with pkgs; [
			noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-emoji
		];
	};	
	
	nix = {
		gc = {
			automatic = true;
			dates = "daily";
			options = "--delete-older-than 4d";
		};
		optimise.automatic = true;
	};


	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		kernelModules = [ ];
		initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "uas" "sd_mod" ];
		initrd.kernelModules = [ ];
		extraModulePackages = [ ];
		loader.systemd-boot.enable = true;
  		loader.efi.canTouchEfiVariables = true;
	};

	fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/70432f73-0f6a-426b-9f38-2ed4f43dbbf8";
			fsType = "btrfs";
			options = [ "compress=zstd"];
		};
		"/boot" = { 
			device = "/dev/disk/by-uuid/E29C-75FB";
			fsType = "vfat";
			options = [ "fmask=0077" "dmask=0077" ];
		};
	};

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

	hardware = {
		enableRedistributableFirmware = true;
		cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
		sensor.iio.enable = true;
		graphics = {
			enable = true;
			extraPackages = with pkgs; [
				intel-media-driver
				intel-compute-runtime
			];
		};
	};

  	system.stateVersion = "24.11"; # Do not change
}

