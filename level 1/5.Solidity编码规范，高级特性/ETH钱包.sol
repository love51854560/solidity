pragma solidity ^0.8.28;

/*
1.任何人都可以发送金额到合约
2.只有owner可以取款
3.3种取钱方式
*/

contract EtherWallet {
    address payable public immutable owner;
    event Log(string funName, address from, uint256 value, bytes data);

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }

    function withdraw1() external {
        // 适用于简单的转账操作，其中接收者不需要执行任何复杂的逻辑。
        // 如果发送失败（例如接收者合约执行时发生错误或 revert），会自动抛出异常，回滚交易。
        require(owner == msg.sender, "Not owner");
        payable(msg.sender).transfer(100);
    }

    function withdraw2() external {
        // 适用于需要手动检查失败的转账操作，通常使用 send 进行转账时会检查返回值。
        require(owner == msg.sender, "Not owner");
        bool success = payable(msg.sender).send(200);
        require(success, "Send Failed");
    }

    function withdraw3() external {
        // call适用于需要与其他合约交互的场景，或者需要灵活控制gas使用量的场景。
        // 可以发送ETH和gas，然后abi编码后与其他合约交互，这里的其他合约可能是msg.sender调用者
        require(owner == msg.sender, "Not owner");
        (bool success, ) = msg.sender.call{
            value: address(this).balance,
            gas: 100
        }(abi.encodeWithSignature(""));
        require(success, "Send Failed");
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
