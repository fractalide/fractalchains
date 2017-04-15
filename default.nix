{
  fractalide ? import <fractalide> {}
  , buffet ? fractalide.buffet
  , rs ? null
  , purs ? null
}:

let
  inherit (buffet.pkgs.lib) attrVals recursiveUpdate;
  inherit (buffet.pkgs) writeTextFile;
  inherit (builtins) head;
  target = if rs != null then { name = "rs"; nodes = newBuffet.nodes.rs; node = rs;}
    else if purs != null then { name = "purs"; nodes = newBuffet.nodes.purs; node = purs;}
    else { name = "rs"; nodes = newBuffet.nodes.rs; node = rs;};
  targetNode = (head (attrVals [target.node] target.nodes));
  newBuffet = {
    nodes = recursiveUpdate buffet.nodes fractalNodes;
    edges = buffet.edges // fractalEdges;
    support = buffet.support;
    imsg = buffet.imsg;
    mods = buffet.mods;
    pkgs = buffet.pkgs;
  };
  fractalEdges = import ./edges { buffet = newBuffet; };
  fractalNodes = import ./nodes { buffet = newBuffet; };
  fvm = import (<fractalide> + "/nodes/fvm/${target.name}") { buffet = newBuffet; };
  test = writeTextFile {
    name = targetNode.name;
    text = "${fvm}/bin/fvm ${targetNode}";
    executable = true;
  };
in
{ nodes = fractalNodes; edges = fractalEdges; test = test; service = ./service.nix; }
