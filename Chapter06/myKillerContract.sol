pragma solidity ^0.4.11;

contract MyKillerContract {
    address owner;
    
    function MyKillerContract() public {
        owner = msg.sender;
    }
    
    function getCreator() public constant returns(address) {
        return owner;
    }
    
    function kill() public {
        if(msg.sender == owner) {
            selfdestruct(msg.sender);
        }
    }
}