# FractalChains

[![Build Status](https://travis-ci.org/fractalide/fractalchains.svg?branch=master)](https://travis-ci.org/fractalide/fractalchains)

## Project Description:

An Ethereum Classic Client

## Problem:

It would seem every Ethereum Client is for human beings.

## Solution:

Make an Ethereum Client for machines.

## Stability Status:

- [x] Raw
- [ ] Draft
- [ ] Stable
- [ ] Deprecated
- [ ] Legacy

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
