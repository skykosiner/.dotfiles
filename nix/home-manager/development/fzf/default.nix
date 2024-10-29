{ pkgs, ... }:

{
    home.packages = with pkgs; [
        fzf
    ];

    programs.fzf = {
        enable = true;
        defaultOptions = [
            "--height 40%"
            "--border=rounded"
        ];
    };
}
