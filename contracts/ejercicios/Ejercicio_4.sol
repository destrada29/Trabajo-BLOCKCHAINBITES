// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Ejercicio_4 {
    // GRANULAR ROLES
    //
    // Develop a system based on privileges to call particular methods of a smart contract.
    //
    // Each method could be called only by the person who has a particular role
    //
    // For instance, 'methodOne' could only be called by people who have ROLE_ONE
    // For instance. 'methodTwo' could only be called by people who have ROLE_TWO
    //
    // Implement the following modifier: onlyRole(ROLE)
    // This modifier checks that the person calling that method has that particular ROLE
    // If not, throw a message stating "You don't have assigned that role."
    //
    // Implement the method grantRole(wallet, ROLE)
    // This method grants a ROLE to a particular address
    // After that address is granted with that ROLE, that account can call methods protected by hasRole(ROLE)
    //
    // Implement the method hasRole(wallet, ROLE)
    // This method checks whether a given wallet has a particular ROLE or not
    // It returns true or false.
    //
    // The method grantRole should be protected by the modifer onlyOwner.
    // This modifier checks that only the person who published the smart contract passes the modifier validation.
    // Capture the person who published the smart contract in the constructor
    // The validation error for this modifier should be "You are not the owner."
    //
    //  - npx hardhat test test/EjercicioTesting_4.js
    // ROLES:
    
    address public owner;
    bytes32 public constant ROLE_ONE = keccak256("ROLE_ONE");
    bytes32 public constant ROLE_TWO = keccak256("ROLE_TWO");
    bytes32 public constant ROLE_THREE = keccak256("ROLE_THREE");

    mapping(address => mapping(bytes32 => bool)) private _roles;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyRole(bytes32 role) {
        require(hasRole(msg.sender, role), "You don't have assigned that role.");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner.");
        _;
    }

    function methodOne() public onlyRole(ROLE_ONE) {
        
    }

    function methodTwo() public onlyRole(ROLE_TWO) {
        
    }

    function methodThree() public onlyRole(ROLE_THREE) {
        
    }

    function grantRole(address _wallet, bytes32 _role) public onlyOwner {
        _roles[_wallet][_role] = true;
    }

    function hasRole(address _wallet, bytes32 _role) public view returns (bool) {
        return _roles[_wallet][_role];
    }
}
