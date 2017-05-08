{ subgraph, nodes, edges }:

subgraph {
  src = ./.;
  flowscript = with nodes.rs; ''
    sortin => sort(${algorand_sortition}) => sortout
  '';
}
