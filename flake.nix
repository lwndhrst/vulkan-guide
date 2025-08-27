{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in {
      devShell.${system} = pkgs.mkShell {
        packages = with pkgs; [
          cmake
          ninja
          pkg-config

          clang-tools

          vulkan-headers
          vulkan-loader
          vulkan-memory-allocator
          vulkan-utility-libraries

          # wayland dependencies for SDL
          libffi
          libGL
          libxkbcommon
          wayland
          wayland-protocols
          wayland-scanner
        ];

        shellHook = ''
          export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.libxkbcommon}/lib
          export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.wayland}/lib
        '';
      };
    };
}
