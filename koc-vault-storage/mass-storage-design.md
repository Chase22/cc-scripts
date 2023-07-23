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
## Storage Slot Id
Each storage slot get's assigned a unique id accross the entire network. The numeric id is build as follows:
```
[ComputerId][Side][Slot]
```
Where side is encoded from the string as follows 

| Side  | Id  |
| ----- | --- |
| up    | 1   |
| down  | 2   |
| left  | 3   |
| right | 4   |
| front | 5   |
| back  | 6   |

And slot is a padded 3 digit number

Examle: The third slot on the right side of computer 12 would get the id: `124003`


## Storage Table

| Field         | Type   | Description                       |
| ------------- | ------ | --------------------------------- |
| StorageSlotID | Number | Encoded slot id                   |
| Item          | String | Name of the Item in the slot      |
| Amount        | Number | Amount of items in the given slot |

# Messages

## Slot updated
Send whenever a computer updates one of it's inventory slots

| Field         | Type   | Description                       |
| ------------- | ------ | --------------------------------- |
| StorageSlotID | Number | Encoded slot id                   |
| Item          | String | Name of the Item in the slot      |
| Amount        | Number | Amount of items in the given slot |

## 