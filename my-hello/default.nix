{} :
with import <nixpkgs> {};
let
  my-hello-no-fhs = stdenv.mkDerivation {
    name = "my-hello-no-fhs";
    builder = ./builder.sh;
    dpkg = dpkg;
    src = fetchurl {
      url = "http://ftp.us.debian.org/debian/pool/main/h/hello-traditional/hello-traditional_2.10-5_amd64.deb";
      sha256 = "135532d038deadf7f233f5c228294346a5e55551c8118fb6de7dfc6b3f409f91";
    };
  };
in {
  my-hello = buildFHSUserEnv {
    name = "my-hello";
    targetPkgs = pkgs: [ my-hello-no-fhs ];
    multiPkgs = pkgs: [ pkgs.dpkg ];
    runScript = "hello";
  };
}
