{ buffet }:

# Please refer to section 2.6 namely Evolution of Public Contracts
# of the Collective Code Construction Contract in CONTRIBUTING.md
let
  callPackage = buffet.pkgs.lib.callPackageWith ( buffet.pkgs // buffet.support.node.rs // buffet.support // buffet );

in
{
  # RAW NODES
  algorand = callPackage ./algorand {};
  algorand_sortition = callPackage ./algorand/sortition {};
  test = callPackage ./test {};
  # DRAFT NODES
  # STABLE NODES
  # DEPRECATED NODES
  # LEGACY NODES
}
