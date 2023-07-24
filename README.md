# vault-storage-manager

A program for cc:tweaked to monitor create item vaults and dispense items into an output chest

## Feature
- Request any item stored within the connected item vaults
- Request any number of items
- Output monitor to keep track of all items

## Setup

**Following items are required for setup**
- One computer (normal or advanced)
- One chest
- Create Item Vaults
- network modems
- network cables
- optionally: Monitors (normal or advanced)

![setup](setup.png)

Setup the chest and computer at an easily reachable system. Optionally add a monitor. A too small monitor might cause problems displaying items. At least 4 wide should be sufficient.

| :warning: Make sure there is only one chest in the system |
|-----------------------------------------------------------|

Setup any number of items vaults of any size.

Connect everything using network modems and cables (note the 256 maximum range of network cables. Chests can only be connected from the bottom). All modems must be turend on by right-clicking

Execute the installer using
```shell
wget run https://raw.githubusercontent.com/Chase22/computercraft-vault-dispenser/main/install.lua
```

The install will download all required components and setup the computer

| :warning: This will override your startup script |
|--------------------------------------------------|

Once finished the computer will reboot into the system.