
# Fire Emblem: Thracia 776

This is a disassembly of Fire Emblem: Thracia 776.

It builds a headerless ROM release version of FE5 `sha1: 75B504921D08E313FF58150E40121AC701884517`

### Setting up the repository

* Have a recent version of [**python 3**](https://www.python.org/) installed and in your path.

* Have `GNU Make` (and other GNU tools).

* Spaces in your filepath might break things.

* You must have a headerless copy of the Fire Emblem: Thracia 776 ROM named `FE5.sfc` in the repository directory.

* Get or build the tools [**64tass**](https://sourceforge.net/projects/tass64/) and [**SuperFamiconv**](https://github.com/Optiroc/SuperFamiconv) and place them in the `TOOLS/` folder.

* Grab the [**tools folder**](https://github.com/ZaneAvernathy/FE5Tools) and place it in the same folder as this repo, i.e. `<root>/FE5Tools` and `<root>/FireEmblem5`.

* Grab the library [**VoltEdge**](https://github.com/ZaneAvernathy/VoltEdge) and place it in the same folder as this repo, i.e. `<root>/VoltEdge` and `<root>/FireEmblem5`.

You can now build `FE5_Disassembly.sfc` using `make`.