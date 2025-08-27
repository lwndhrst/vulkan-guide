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
          pkg-config

          cmake
          llvmPackages.clang-unwrapped
          ninja

          vulkan-headers
          vulkan-loader
          vulkan-memory-allocator
          vulkan-utility-libraries
        ];
      };
    };
}
