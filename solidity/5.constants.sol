pragma solidity ^0.8.24;

contract Constants {
    // coding convention to uppercase constant variables
    // The constant variable must be initialized at the time of declaration and cannot be changed thereafter
    // Only string and bytes can be declared as constants
    address public constant MY_ADDRESS =
        0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint256 public constant MY_UINT = 123;
}
