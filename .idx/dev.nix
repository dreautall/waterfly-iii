{ pkgs }: {
  channel = "stable-23.11";
  packages = [
    pkgs.nodePackages.firebase-tools
    pkgs.jdk17
    pkgs.unzip
  ];
  idx.extensions = [
    "dart-code.dart-code"
    "dart-code.flutter"
    "google.arb-editor"
    "github.vscode-github-actions"
    "github.vscode-pull-request-github"
    "eamodio.gitlens"
    "jock.svg"
  ];
  idx.previews = {
    previews = {
      android = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "android"
          "-d"
          "emulator-5554"
        ];
        manager = "flutter";
      };
    };
  };
}
