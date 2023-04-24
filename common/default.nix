{ config, pkgs, ...}:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };

    overlays =
      # Apply each overlay found in the /overlays directory
      let path = ../overlays; in with builtins;
      map (n: import (path + ("/" + n)))
          (filter (n: match ".*\\.nix" n != null ||
                      pathExists (path + ("/" + n + "/default.nix")))
                  (attrNames (readDir path)))

      ++ [(import (builtins.fetchTarball {
               url = "https://github.com/brando2147/emacs-overlay/archive/refs/heads/master.tar.gz";
               #sha256 = "07ks98m0zj61jz20fw2vqax1c61374hr06fzmw9c9xq70bsx1y9l";
               sha256 = "0a48fq06hfn9r5yfhl1s23h296czlr5kz4xdm0brbi46dpds9n8k";
           }))];
  };
}