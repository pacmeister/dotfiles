with import <nixpkgs> {};

stdenv.mkDerivation rec {
    name = "cudatext-bin";
    version = "1.105.0.0";

#    src = fetchurl {
#        url = "https://www.fosshub.com/CudaText.html?dwl=cudatext-linux-gtk2-amd64-1.105.0.0.tar.xz";
#        sha256 = "0dsx23gcmz4m4ia1jslr14hvlqilb8cg5jm13j93gyljxp71v3nz";
#    };

    src = ./cudatext-linux-gtk2-amd64-1.105.0.0.tar.xz;

    nativeBuildInputs = [
        autoPatchelfHook
    ];

    buildInputs = [
        gtk2
        python3
    ];

    unpackPhase = ''
	tar -xvf $src
    '';

    installPhase = ''
	chmod +x cudatext
	mkdir -p $out/pkg/settings
	mkdir -p $out/bin
        cp cudatext $out/bin
        cp cudatext $out/pkg/bin
	mv * $out/pkg
#echo "#!/bin/sh
#	../pkg/cudatext -s=~/.config/cudatext/settings
#	" > $out/bin/cudatext
#	chmod +x $out/bin/cudatext
    '';

    meta = with stdenv.lib; {
        homepage = "http://uvviewsoft.com/cudatext/";
        description = "CudaText text editor binary";
        platforms = platforms.linux;
        maintainers = with maintainers; [ makefu ];
    };
}
