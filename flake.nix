{
  description = "Isaac Sim MCP Server development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python311;
      in
      {
        devShells.default = pkgs.mkShell {
          name = "isaacsim-mcp-server";

          packages = [
            python
            pkgs.uv
            pkgs.ruff
            pkgs.pre-commit
            pkgs.xorg.xhost
            pkgs.docker-compose
          ];

          env = {
            # setup_python_env.sh reads this to select the Python interpreter
            PYTHON_SPEC = "${python}/bin/python3.11";
          };

          shellHook = ''
            echo "isaacsim-mcp-server dev shell (Python ${python.version})"
            echo "  setup: ./scripts/setup_python_env.sh"
            echo "  activate: source .venv/bin/activate"
          '';
        };
      }
    );
}
