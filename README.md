# FractalChains

[![Build Status](https://travis-ci.org/fractalide/fractalchains.svg?branch=master)](https://travis-ci.org/fractalide/fractalchains)

## Project Description:

An Ethereum Classic Client

## Problem:

It would seem every Ethereum Client is for human beings.

## Solution:

Make an Ethereum Client for machines.

## Build Instructions
Ensure you've installed [nix](https://nixos.org/nix).
```
$ export NIX_PATH+=:fractalide=https://github.com/fractalide/fractalide/archive/v20170415.tar.gz
$ git clone git://github.com/fractalide/fractalchains.git
$ cd fractalchains
$ nix-build --argstr rs test
```
or
```
$ git clone git://github.com/fractalide/fractalchains.git
$ cd fractalchains
$ nix-build --argstr rs test -I fractalide=/path/to/your/fractalide/clone
```
## Guidelines

* A specification SHOULD be created and modified by pull requests according to [RFC 1/C4](CONTRIBUTING.md)
* Specification lifecycle SHOULD follow the lifecycle defined in [RFC 2/COSS](nodes/rfc/2/README.md)
* Specification SHOULD use the MPLv2 license
* Specification SHOULD use [RFC 2119](http://tools.ietf.org/html/rfc2119) key words.
* Non-cosmetic changes are allowed only on Raw and Draft specifications.

## Stability Status:

* Raw
  * [3/ALGORAND](nodes/rs/algorand/README.md)
* Draft
  * [2/COSS](nodes/rfc/2/README.md)
* Stable
  * [1/C4](CONTRIBUTING.md)
* Deprecated
* Retired
