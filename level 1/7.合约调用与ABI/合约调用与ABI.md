## ABI（应用二进制接口，Application Binary Interface）的作用
可以ABI实现合约对合约的调用，应用对合约的调用（web3.js或者etherum.js）

1.函数和事件的编码格式：它定义了智能合约函数的输入输出参数格式以及事件的格式。
2.合约与外部系统的交互：通过 ABI，前端或后端应用可以与已部署的合约进行函数调用、事件监听和数据交换。
3.确保合约的可调用性：ABI 使得外部系统能够正确地调用合约并解析合约的返回结果。
4.保障数据传输和安全：它保证了数据在 EVM 中的正确编码、解码和传输。

## 合约对合约的调用 通过实例化合约
```
// 合约B
pragma solidity ^0.8.0;
contract ContractB {
    uint256 public value;
    function setValue(uint256 _value) public {
        value = _value;
    }
    function getValue() public view returns (uint256) {
        return value;
    }
}
```
```
// 合约A
pragma solidity ^0.8.0;
// 引入合约B的ABI
import "./ContractB.sol";
contract ContractA {
    ContractB public contractB; // 合约B实例
    constructor(address _contractBAddress) {
        contractB = ContractB(_contractBAddress); // 实例化合约B
    }
    // 向合约B设置值
    function setValueInContractB(uint256 _value) public {
        contractB.setValue(_value);
    }
    // 从合约B获取值
    function getValueFromContractB() public view returns (uint256) {
        return contractB.getValue();
    }
}
```