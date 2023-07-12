// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.4;

contract BasicAddressAccess {
    address public contractOwner; // for function permissions 
    string public contractName; // for quality of life
    uint public totalApproved; // updated with every approve / revoke action by contractOwner
    mapping (address => bool) public approvedAddresses; // check individual address access with the hasAccess(_address) function

    constructor(string memory _contractName) {
        contractOwner = msg.sender;
        contractName = _contractName;
        approveAccess(msg.sender);
    }

    receive() external payable { // non payable by require
        require(msg.value == 0, "This contract cannot receive funds.");
    }

    fallback() external {} // non payable at core

    // this function allows anyone to check if an address has access
    function hasAccess(address _address) public view returns(bool) {
        return approvedAddresses[_address];
    }

    // allow user to transfer access from their current address to another address
    function transferAccess(address _new_address) public approvedOnly { 
        revokeAccess(msg.sender);
        approveAccess(_new_address);
        if(msg.sender == contractOwner){
            contractOwner = _new_address;
        }
    }

    // contractOwner can approve any address for access
    function approveAccess(address _address) public onlyContractOwner {
        require(hasAccess(_address) == false, "This address is already approved.");
        approvedAddresses[_address] = true;
        totalApproved++;
    }

    // contractOwner can revoke access to any address, except for their own
    function revokeAccess(address _address) public onlyContractOwner {
        _revokeAccess(_address);
    }

    // internal revoke function that is used by contractOwner's revoke & also the public "burn" function
    function _revokeAccess(address _address) private {
        require(hasAccess(_address) == true, "You do not need to revoke access because this address has not been approved previously.");
        require(_address != contractOwner, "You cannot remove the contractOwner address from the approved address list.");
        approvedAddresses[_address] = false;
        totalApproved--;
    }

    function burnAccess() public approvedOnly {
        _revokeAccess(msg.sender);
    }

    modifier onlyContractOwner() {
        require(msg.sender == contractOwner, "The msg sender is not the contractOwner.");
        _;
    }

    modifier approvedOnly() {
        require(approvedAddresses[msg.sender] == true, "The msg sender is not approved to use this function.");
        _;
    }
    
}
