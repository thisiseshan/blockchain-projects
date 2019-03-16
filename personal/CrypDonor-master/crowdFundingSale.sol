pragma solidity ^0.5.2;

contract CFS{

//key value mapping for address and amount invested by partiicipant
mapping(address => uint) donor;
mapping(address => uint) needy;
mapping(address => uint) public population;
address[] public donorAddr;
address[] public needyAddr;
address public owner;
enum Stages { acceptingAmt, acceptingEnd , Inactive }


Stages public stage = Stages.acceptingAmt;

uint public creationTime = now;

modifier atStage(Stages _stage) {
require(
stage == _stage,
"Function cannot be called at this time."
);
_;
}

function nextStage() internal {
    stage = Stages(uint(stage) + 1);
}

modifier timedTransitions() {
    if (stage == Stages.acceptingAmt &&
    now >= creationTime + 6 days)
    {
    
    nextStage();
    }
    if (stage == Stages.acceptingEnd &&
    now >= creationTime + 12 days)
    nextStage();
    
    _;
}

constructor() public payable{
    owner = msg.sender;
}

function setFinancialIndex() public{
population[msg.sender] = 9899;
}

function donate (address payable taker) public payable timedTransitions {
// if (stage != Stages.acceptingAmt) {return;}
    uint value = msg.value;
    require(value >= 0.005 ether);
    donor[msg.sender] = value;
    needy[taker] += value ;
    donorAddr.push(msg.sender);
    uint ini_fin_index = population[taker];
    population[taker] += (value/ini_fin_index) * 100;



}


function needyadder() public {

    needy[msg.sender] = 0;
    needyAddr.push(msg.sender);

}

function needyWithdraw () public payable timedTransitions atStage(Stages.acceptingEnd) {
    if (stage != Stages.acceptingEnd) {return;}
    msg.sender.transfer(needy[msg.sender]);
}




}

