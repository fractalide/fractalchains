{ fractalide ? import <fractalide> {}
  , buffet   ? fractalide.buffet
  , backend  ? "rs"
  , node     ? null
  , release  ? true
  , verbose  ? false
}:
with buffet.pkgs.lib;
let
  inherit (buffet.pkgs.lib) attrVals recursiveUpdate;
  inherit (buffet.pkgs) writeTextFile;
  inherit (builtins) head;
  target = getAttrFromPath ["${backend}" "${node}"] fractalNodes;
  newBuffet = {
    nodes = recursiveUpdate buffet.nodes fractalNodes;
    edges = recursiveUpdate buffet.edges fractalEdges;
    support = buffet.support;
    imsg = buffet.imsg;
    mods = recursiveUpdate buffet.mods fractalMods;
    pkgs = buffet.pkgs;
    release = buffet.release;
    verbose = buffet.verbose;
  };
  fractalEdges = import ./edges { buffet = newBuffet; };
  fractalNodes = import ./nodes { buffet = newBuffet; };
  fractalMods  = import ./mods  { buffet = newBuffet; };
  fvm = import (<fractalide> + "/nodes/fvm/${backend}") { buffet = newBuffet; };
  test = writeTextFile {
    name = target.name;
    text = "${fvm}/bin/fvm ${target}";
    executable = true;
  };
in
{ nodes = fractalNodes; edges = fractalEdges; test = test; service = ./service.nix; }
