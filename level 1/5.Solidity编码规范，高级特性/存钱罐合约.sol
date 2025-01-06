pragma solidity ^0.8.28;

contract Bank {
    address public immutable owner;

    event Deposit(address _ads,uint256 amount);

    event Withdraw(uint256 amount);

    //收到ETH事件
    receive() external payable{
        emit Deposit(msg.sender,msg.value);
    }

    // 在构造函数中合约能够接收以太币（ETH），payable 关键字是必需
    constructor() payable{
        owner = msg.sender;
    }

    function withdraw()  external {
        require(msg.sender == owner,"Not Owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }

    function getBalance() external view returns (uint256){
        return address(this).balance;
    }
}
