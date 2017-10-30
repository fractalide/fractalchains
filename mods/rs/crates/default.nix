{ build-rust-package, pkgs, release, verbose }:
let
    all_crates_1_1_1_ = { dependencies?[], features?[] }: build-rust-package {
      crateName = "all_crates";
      version = "1.1.1";
      fractalType = "crate";
      src = ./.;
      inherit dependencies features release verbose;
    };
    libc_0_2_30_ = { dependencies?[], features?[] }: build-rust-package {
      crateName = "libc";
      version = "0.2.30";
      fractalType = "crate";
      src = pkgs.fetchzip {
        url = "https://crates.io/api/v1/crates/libc/0.2.30/download";
        sha256 = "1c4gi6r5gbpbw3dmryc98x059awl4003cfz5kd6lqm03gp62wlkw";
        name = "libc-0.2.30.tar.gz";
      };
      inherit dependencies features release verbose;
    };
    memchr_1_0_1_ = { dependencies?[], features?[] }: build-rust-package {
      crateName = "memchr";
      version = "1.0.1";
      fractalType = "crate";
      src = pkgs.fetchzip {
        url = "https://crates.io/api/v1/crates/memchr/1.0.1/download";
        sha256 = "071m5y0zm9p1k7pzqm20f44ixvmycf71xsrpayqaypxrjwchnkxm";
        name = "memchr-1.0.1.tar.gz";
      };
      libName = "memchr";
      inherit dependencies features release verbose;
    };
    nom_3_2_0_ = { dependencies?[], features?[] }: build-rust-package {
      crateName = "nom";
      version = "3.2.0";
      fractalType = "crate";
      src = pkgs.fetchzip {
        url = "https://crates.io/api/v1/crates/nom/3.2.0/download";
        sha256 = "16ccwwqi09ai1yf71gpqhih915m7ixyrwbjf6lmhfdnxp0igg6sw";
        name = "nom-3.2.0.tar.gz";
      };
      inherit dependencies features release verbose;
    };

in
rec {
  all_crates_1_1_1 = all_crates_1_1_1_ {
    dependencies = [ nom_3_2_0 ];
  };
  libc_0_2_30 = libc_0_2_30_ {
    features = [ "use_std" ];
  };
  memchr_1_0_1 = memchr_1_0_1_ {
    dependencies = [ libc_0_2_30 ];
    features = [ "use_std" ];
  };
  nom_3_2_0 = nom_3_2_0_ {
    dependencies = [ memchr_1_0_1 ];
    features = [ "std" "stream" ];
  };
  all_crates = all_crates_1_1_1;
  libc = libc_0_2_30;
  memchr = memchr_1_0_1;
  nom = nom_3_2_0;
}
