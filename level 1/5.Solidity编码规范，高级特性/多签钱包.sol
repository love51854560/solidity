pragma solidity ^0.8.28;

/*
多签钱包的功能: 合约有多个owner，一笔交易发出后，需要多个owner确认，确认数达到最低要求数之后，才可以真正的执行。

1.部署时候传入地址参数和需要的签名数
-- 多个owner地址
-- 发起交易的最低签名数
2.有接受ETH主币的方法，
3.除了存款外，其他所有方法都需要owner地址才可以触发
4.发送前需要检测是否获得了足够的签名数
5.使用发出的交易数量值作为签名的凭据ID
6.每次修改状态变量都需要抛出事件
7.允许批准的交易，在没有真正执行前取消
8.足够数量的approve后，才允许真正执行
*/

contract EtherWallet {
    address[] public owners;
    mapping (address => bool) public isOwner;
    uint256 public required;
    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        bool exected;
    }
    mapping(uint256 => mapping(address => bool)) public approved; // 存储同意执行的交易，但还未被执行
    Transaction[] public transactions;// 存储已经执行的交易
    
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    /*
        被indexed标记的参数在日志中会被作为索引字段，这意味着你可以用这些字段来进行筛选。
        比如，在区块链浏览器（如 Etherscan）或前端应用中，用户可以根据这些参数轻松查询到相关的事件。
        每个事件最多只能有三个被indexed的参数，只有address类型、uint类型、bytes类型的参数可以被索引
    */
    event Deposit(address indexed sender, uint256 amount);
    event Submit(uint256 indexed txId);
    event Approve(address indexed owner, uint256 indexed txId);
    event Revoke(address indexed owner, uint256 indexed txId);
    event Execute(uint256 indexed txId);

    //修饰器必须写在合约内部，可以通过继承或者引用合约中的modifier来实现复用
    modifier onlyOwner {
        require(isOwner[msg.sender],"not owner");
        // 如果是的话，继续运行函数主体；否则报错并revert交易
        _;
    }

    modifier txExists(uint256 _txId) {
        require(_txId < transactions.length, "tx doesn't exist");
        _;
    }

    // 检测交易是否已经被同意
     modifier notApproved(uint256 _txId) {
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    // 检测交易是否已经被执行
    modifier notExecuted(uint256 _txId) {
        require(!transactions[_txId].exected, "tx is exected");
        _;
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
