pragma solidity ^0.4.11;
// define new contract
contract ArithValue{
	uint number;
	function ArithValue() public {  //constructor function with default value
		number = 100;
	}
// constructor function	to set new value
	function setNumber(uint theValue) public {
	    number = theValue;
	}
// constructor function	to fetch the new value	
	function fetchNumber() public constant returns (uint) {
		return number;
	}
// constructor function	to increment by one	
	function incrementNumber() public {
	    number=number + 1;
	}
// constructor function	to decrement by one	
	function decrementNumber() public {
	    number=number - 1;
	}
}