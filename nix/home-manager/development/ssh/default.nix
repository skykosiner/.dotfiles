{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "mac" = {
        hostname = "mac-mini.lan";
        user = "skykosiner";
      };
      "main-box" = {
        hostname = "main-box.lan";
        user = "sky";
      };
      "nix-btw" = {
        hostname = "nix-btw.lan";
        user = "sky";
      };
      "ssh.kosiner.codes" = {
        user = "sky";
        proxyCommand = "cloudflared access ssh --hostname %h";
      };
      "ssh-main.kosiner.codes" = {
        user = "sky";
        proxyCommand = "cloudflared access ssh --hostname %h";
      };
      "skykosiner.com" = {
        user = "root";
        port = 42069;
      };
      "lg_tv" = {
        hostname = "10.0.0.200";
        port = 9922;
        user = "prisoner";
        identityFile = "~/.ssh/lg_tv_webos";
        extraOptions = {
          "HostKeyAlgorithms" = "+ssh-rsa";
          "PubKeyacceptedkeytypes" = "+ssh-rsa";
        };
      };
    };
  };
}
