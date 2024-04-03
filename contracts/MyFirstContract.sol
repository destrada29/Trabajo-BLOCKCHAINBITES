// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

contract MyFirstContract {
    uint256 year = 2024;

    function updateYear(uint256 _year) public {
        year = _year;
    }

    function getYear() public view returns (uint256) {
        return year;
    }
}
