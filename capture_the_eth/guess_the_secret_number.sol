// pragma solidity ^0.8.0;

// contract GuessTheSecretNumberChallenge {
//     function guess(uint8 n) public payable {}
// }

// contract ExploitTheSecretNumber {
//     address payable owner;
//     bytes32 answerHash = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;
//     uint16 public answer;

//     constructor() public payable{
//         owner = payable(msg.sender);
//     }

//     function withdraw() public payable{
//         require(owner == msg.sender);
//         owner.transfer(address(this).balance);
//     }

//     function exploit() public payable {
//         for(uint16 i; i < 256; i++){
//             if(keccak256(abi.encodePacked(i)) == answerHash){
//                 answer = i;
//                 break;
//             }
//         }
//     }

//     receive() external payable{}
// }

// pragma solidity ^0.4.21;

// contract GuessTheSecretNumberChallenge {
//     bytes32 answerHash = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;
//     uint8 public result;
//     bytes32[256] public hash;

//     function guess() public{

//         for(uint8 i; i < 255; i++){
//             hash[i] = keccak256(i);
//             if (keccak256(i) == answerHash) {
//                 result = i;
//             }
//         }
//     }
// }

pragma solidity ^0.4.21;

contract GuessTheSecretNumberChallenge {
    bytes32 answerHash = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;

    function GuessTheSecretNumberChallenge() public payable {
        require(msg.value == 1 ether);
    }
    
    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether);

        if (keccak256(n) == answerHash) {
            msg.sender.transfer(2 ether);
        }
    }
}
