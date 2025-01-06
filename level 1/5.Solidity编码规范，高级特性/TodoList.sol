pragma solidity ^0.8.28;

contract TodoList {
    struct Todo {
        string name;
        bool isCompleted;
    }

    Todo[] public list;

    // memory的使用至关重要，可以节省gas，增加性能
    // memory只能修饰引用类型,string,array,struct
    function create(string memory _name) external {
        list.push(Todo({name: _name, isCompleted: false}));
    }

    // 修改任务名称
    function modiName1(uint256 index_, string memory name_) external {
        // 方法1: 直接修改
        // 代码简洁，少量gas消耗
        // 如果结构体较大，会导致不必要的内存读写
        list[index_].name = name_;
    }
    
    function modiName2(uint256 index_, string memory name_) external {
        // 方法2: 临时变量
        // 如果结构体较大，内存读写效率会更高，会节省gas
        Todo storage temp = list[index_];
        temp.name = name_;
    }

    // 修改完成状态1:手动指定完成或者未完成
    function modiStatus1(uint256 index_,bool status_) external {
        list[index_].isCompleted = status_;
    }
    // 修改完成状态2:自动切换 toggle
    function modiStatus2(uint256 index_) external {
        list[index_].isCompleted = !list[index_].isCompleted;
    }

    // 获取任务1: memory
    // 29448 gas
    function get1(uint256 index_) external view
        returns(string memory name_,bool status_){
        Todo memory temp = list[index_];
        return (temp.name,temp.isCompleted);
    }
    // 获取任务2: storage 
    // 预期：get2 的 gas 费用比较低（相对 get1）
    // 29388 gas
    // storage特别适合在读取操作中
    function get2(uint256 index_) external view
        returns(string memory name_,bool status_){
        Todo storage temp = list[index_];
        return (temp.name,temp.isCompleted);
    }
}
