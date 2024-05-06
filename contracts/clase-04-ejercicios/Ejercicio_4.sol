// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "hardhat/console.sol";

contract Ejercicio_4 {
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
