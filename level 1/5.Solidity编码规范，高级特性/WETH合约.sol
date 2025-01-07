pragma solidity ^0.8.28;

/*
WETH 是包装ETH主币，实际的换算比例还是1:1，作为ERC20的合约。 标准的ERC20合约包括如下几个

3个查询
-- balanceOf: 查询指定地址的代币数量
-- allowance: 查询一个地址对另外一个地址的剩余授权额度
-- totalSupply: 查询当前合约的合约代币总量

2个交易
-- transfer: 从当前调用者地址发送指定数量的代币到指定地址。
这是一个写入方法，所以还会抛出一个 Transfer 事件。
-- transferFrom: 当向另外一个合约地址存款时，对方合约必须调用 transferFrom 才可以把代币拿到它自己的合约中。

2个事件
-- Transfer
-- Approval

1个授权
-- approve: 授权指定地址可以操作调用者的最大代币数量。
*/
contract WETH {
    string public name = "Wrapped Ether";
    string public symbol = "WETH";
    uint8 public decimals = 18;
    /*
        被indexed标记的参数在日志中会被作为索引字段，这意味着你可以用这些字段来进行筛选。
        比如，在区块链浏览器（如 Etherscan）或前端应用中，用户可以根据这些参数轻松查询到相关的事件。
        每个事件最多只能有三个被indexed的参数，只有address类型、uint类型、bytes类型的参数可以被索引
    */
    event Approval(
        address indexed src,
        address indexed delegateAds,
        uint256 amount
    );
    event Transfer(address indexed src, address indexed toAds, uint256 amount);
    event Deposit(address indexed toAds, uint256 amount);
    event Withdraw(address indexed src, uint256 amount);

    mapping(address => uint256) public balanceOf;
    //一个地址对另外一个地址的授权额度
    mapping(address => mapping(address => uint256)) public allowance;

    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount);
        balanceOf[msg.sender] -= amount;
        //需要接收以太币必须将address类型转换为payable-address类型
        //合约向msg.sender转账一定数量的ETH，address类型自带的一个transfer方法，与下面的transfer不是一个方法
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    function totalSupply() public view returns (uint256) {
        return address(this).balance;
    }

    function approve(
        address delegateAds,
        uint256 amount
    ) public returns (bool) {
        allowance[msg.sender][delegateAds] = amount;
        emit Approval(msg.sender, delegateAds, amount);
        return true;
    }

    function transfer(address toAds, uint256 amount) public returns (bool) {
        return transferFrom(msg.sender, toAds, amount);
    }

    function transferFrom(
        address src,
        address toAds,
        uint256 amount
    ) public returns (bool) {
        require(balanceOf[src] >= amount);
        // 转账来源地址不是调用此方法的地址，需要确认授权额度
        // 代理转账需要这个判断，普通转账不需要
        if (src != msg.sender) {
            require(allowance[src][msg.sender] >= amount);
            allowance[src][msg.sender] -= amount;
        }
        balanceOf[src] -= amount;
        balanceOf[toAds] += amount;
        emit Transfer(src, toAds, amount);
        return true;
    }

    fallback() external payable {
        deposit();
    }

    receive() external payable {
        deposit();
    }
}
