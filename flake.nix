{
  description = "";
  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, devshell }: 
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlays.default ];
        };
      in {
        name = "zig-a-zig-ah";

        packages = rec {
          release = {};
          default = release;
        };

        apps = rec {
          hello = {};
          default = hello;
        };

        devShells = {
          default = pkgs.devshell.mkShell {
            packages = with pkgs; [
              zig
              zls
            ];

            env = [
              {
                name = "PRIMEAGEN";
                value = "GO";
              }
            ];

            commands = [
              {
                name = "hello";
                help = "Is it me you're looking for?";
                command = "whoami";
              }
            ];
          };
        };
      }
    );
}
