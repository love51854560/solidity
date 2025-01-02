pragma solidity ^0.8.24;

contract Immutable {
    // coding convention to uppercase constant variables
    // Immutable variables can be initialized at declaration or constructor time
    // String and bytes can be declared as constants, but not immutable
    // Only numerical variables can declare constant and immutable
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UINT;

    constructor(uint256 _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}
