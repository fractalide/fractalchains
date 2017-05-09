{ subgraph, imsg, nodes, edges }:

subgraph {
  src = ./.;
  flowscript = with nodes.rs; ''
    alg1(${algorand}) out -> in alg2(${algorand})
    alg2(${algorand}) out -> in alg3(${algorand})
    alg3(${algorand}) out -> in alg4(${algorand})
    alg4(${algorand}) out -> in alg5(${algorand})
  '';
}
