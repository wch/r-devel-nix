# R-devel for Nix
=================

This repository contains a Nix expression for building R-devel from source. If you have Nix installed on your Linux or Mac computer, it will allow you to reproducibly build an run R-devel, without requiring you to do a permanent installation of it on your system.


## Building

First, install Nix with flakes enabled. The easiest way to do this is to use the [Determinate Systems Nix installer](https://install.determinate.systems/). (Note that this installer also has the ability to completely uninstall itself.)

Next, build R-devel.

```
nix build github:wch/r-devel-nix -L
```

The `-L` will cause the build logs to be printed to the terminal; if you don't want to see that information, omit `-L`.

Build times:

- On a Mac with an M1 Pro, this takes about 6 minutes.
- On a Linux computer with an AMD Ryzen 5 5560U, this takes about 4 minutes.


Once it is built, you can run R-devel in a few different ways

This will run R-devel directly:

```
nix run github:wch/r-devel-nix
```

Or you can start a shell with R-devel available:

```
nix shell github:wch/r-devel-nix
R
```


## Updating hashes

To update the hashes for r-source and the recommended packages, run:

```
scripts/update-all.sh
```

If there were any changes, you can commit them to the repository.
