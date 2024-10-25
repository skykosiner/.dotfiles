{ pkgs, ... }:

{
    home.packages = with pkgs; [
        fzf
    ];

    programs.fzf = {
        enable = true;
        defaultOptions = [
            "--border"
        ];
    };
}
