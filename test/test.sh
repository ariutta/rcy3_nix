#! /usr/bin/env nix-shell
#! nix-shell ../nix_shell_shebang_dependencies.nix -i bash

# NOTE: what you see above is a [Nix shebang](https://nixos.org/nix/manual/#ssec-nix-shell-shebang).
# We used it instead of this shebang:
# #! /usr/bin/env bash
# because it allows us to specify and load the exact version of every required dependency.

reuse=$1

# see https://stackoverflow.com/a/246128/5354298
get_script_dir() { echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; }
SCRIPT_DIR=$(get_script_dir)

(cd "$SCRIPT_DIR/../rcy3_nix"; bash cytoscapestart.sh)

Rscript "$SCRIPT_DIR/test.R"

if [[ ! -z $reuse ]]; then
	echo 'Cytoscape left open for further use...' > /dev/stderr
else
	(cd "$SCRIPT_DIR/../rcy3_nix"; bash cytoscapestop.sh)
fi
