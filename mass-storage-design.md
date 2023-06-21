# Computers
## MainFrame
- Relays and processes all communication
- Keeps full record of all storage
- Sends dispatch requests to storage controllers
- Only 1 per network

## RequestController
- Frontend to allow user to enter dispatch requests
- Displays storage contents to user

## StorageController
- Connected to 1 or multiple item vaults (or other storage)
- Keeps own storage table
- Regularely updates storage table
- When changed, send updates to master
- Gets dispatch calls from master to dispense items

# Dispatch Requests
When a user request a number of items the MainFrame calculates a number of DispatchRequests. Each request contains the name of a StorageController, a slot and an amount to dispatch from the slot. The MainFrame prioritises lowest slots first, prioritising emptying slot over reducing the number of calls.

# Data Structures
## MainFrame Storage Table

| Field | Type | Description |
|----|---|---|
| ComputerId | Number | The Id of the StorageController |
| Slot | Number | The inventory slot |
| Item | String | Name of the Item in the slot |
| Amount | Number | Amount of items in the given slot |
