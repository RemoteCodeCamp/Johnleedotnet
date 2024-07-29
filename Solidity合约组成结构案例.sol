// SPDX-License-Identifier: MIT
// SPDX许可证标识符，指定合约的许可证类型为MIT
pragma solidity ^0.8.17;
// Pragma指令，指定Solidity编译器的版本

contract SimpleVoting {
    // 合约声明

    struct Voter {
        // 定义一个结构体，表示投票者的相关信息
        bool voted;  // 投票者是否已投票
        uint8 vote;  // 投票者投给的候选人编号
    }

    struct Candidate {
        // 定义一个结构体，表示候选人的相关信息
        string name;  // 候选人的名字
        uint256 voteCount;  // 候选人获得的票数
    }

    address public owner;
    // 状态变量，存储合约的所有者地址

    mapping(address => Voter) public voters;
    // 映射类型，存储每个投票者的地址和其相关信息

    Candidate[] public candidates;
    // 动态数组，存储所有候选人的信息

    event Voted(address indexed voter, uint8 candidate);
    // 事件，在投票后触发，用于记录投票者和其投给的候选人

    modifier onlyOwner() {
        // 修饰器，用于限制只有合约所有者可以执行的函数
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    constructor(string[] memory candidateNames) {
        // 构造函数，在合约部署时执行，用于初始化候选人列表和合约所有者
        owner = msg.sender;
        for (uint8 i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
    }

    function vote(uint8 candidate) public {
        // 普通函数，用于投票
