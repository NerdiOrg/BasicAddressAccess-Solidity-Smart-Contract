# Basic Address Access Smart Contract (Solidity)
This contract allows the owner to approve an address or revoke access. Addresses are added to a public mapping "approvedAddresses". Anyone can check to see if an address has access, so this is best for use cases such as ticketing, clubs, or otherwise non-private information. The contract code be modified to have a private address list instead. `BasicAddressAccess` is a basic smart contract implemented on Ethereum and is written in Solidity.
 The contract is designed to manage and limit access to certain functions based on the address of the sender.

## Table of Contents
1. [Details](#details)
2. [Functions](#functions)
3. [Modifiers](#modifiers)
4. [Deployment](#deployment)

## Details <a name="details"></a>
The contract maintains a list of approved addresses that are granted certain permissions in the contract. The address deploying the contract (contractOwner) is automatically approved upon contract creation.

The contract also has a security measure in place to prevent the reception of funds by setting a requirement in the `receive()` function.

## Functions <a name="functions"></a>

* **hasAccess(address _address)** - Allows anyone to check if a specific address has been approved or not.
* **transferAccess(address _new_address)** - Allows an approved address to transfer its access to a new address. If the contract owner initiates this function, the ownership of the contract is also transferred.
* **approveAccess(address _address)** - Only accessible by the contract owner. This function approves the access for the specified address if it is not already approved.
* **revokeAccess(address _address)** - Only accessible by the contract owner. This function revokes the access for a specified address if it was approved before. The contract owner cannot revoke their own access.

## Modifiers <a name="modifiers"></a>

* **onlyContractOwner()** - Allows a function to be executed only by the contract owner.
* **approvedOnly()** - Allows a function to be executed only by an approved address.

## Deployment <a name="deployment"></a>
This contract can be deployed on any Ethereum-compatible network by using tools like Truffle, Remix, Hardhat etc.

---

## Important

Please, make sure to test this contract thoroughly before deploying it to any main network, as it may have not been audited for potential security vulnerabilities.
