pragma solidity ^0.8.28;

contract CrowdFunding {
    address public immutable beneficiary; // 受益人
    uint256 public immutable fundingGoal; // 筹资目标数量
    uint256 public currentFundingAmount; // 当前筹资数量
    mapping(address => uint256) public funders; // 资助者列表,记录每个资助者资助多少钱
    // 判断键是否已经存在-最安全和最常用的方法是使用一个额外的mapping来记录。
    mapping(address => bool) private fundersInserted; // 某个资助者是否在资助者列表中
    address[] public fundersKey; // 用来获取长度
    bool public AVAILABLED = true; // 控制是否可以众筹

    constructor(address _beneficiary, uint256 _fundingGoal) {
        beneficiary = _beneficiary;
        fundingGoal = _fundingGoal;
    }

    // 用于处理资助者发送的ETH
    // Remix IDE，调用函数时可以直接输入 ETH 数量并发送。
    // 使用Web3.js或Ethers.js时，调用合约函数时需要传递一个value字段，该字段表示要发送的ETH数量（以 Wei 为单位）
    function contrubute() external payable {
        require(AVAILABLED, "CrowdFunding is closed");

        // 检查捐赠金额是否会超过目标金额
        uint256 potentialFundingAmount = currentFundingAmount + msg.value;
        // 记录超出的金额
        uint256 refundAmount = 0;

        if (potentialFundingAmount > fundingGoal) {
            refundAmount = potentialFundingAmount - fundingGoal;
            // 由于超出金额需要退还，需要计算捐赠者实际捐的金额
            funders[msg.sender] += (msg.value - refundAmount);
            // 更新当前众筹的总金额，实际数量就是fundingGoal了
            currentFundingAmount += (msg.value - refundAmount);
        } else {
            // uint256初始值0直接加
            funders[msg.sender] += msg.value;
            currentFundingAmount += msg.value;
        }

        // 标记资助者是否已经资助过
        if (!fundersInserted[msg.sender]) {
            fundersInserted[msg.sender] = true;
            fundersKey.push(msg.sender);
        }

        // 退还超出的金额
        if (refundAmount > 0) {
            payable(msg.sender).transfer(refundAmount);
        }
    }

    function close() external returns (bool) {
        if (currentFundingAmount < fundingGoal) {
            return false;
        }
        uint256 amount = currentFundingAmount;
        // 先将当前众筹金额置为0，防止重入攻击
        currentFundingAmount = 0;
        // 关闭众筹
        AVAILABLED = false;
        // 将众筹金额转给受益人
        payable(beneficiary).transfer(amount);
        return true;
    }

    function getFundersLength() public view returns (uint256) {
        return fundersKey.length;
    }
}
