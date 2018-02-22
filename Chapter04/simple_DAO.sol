pragma solidity ^0.4.11;

contract DAOFundraiser {
	
	mapping(address=>uint) balances;
	
	
	function withdrawAllMyCoins() public {
		
		uint withdrawAmount = balances[msg.sender];
		TypicalWallet wallet = TypicalWallet(msg.sender);
		wallet.payout.value(withdrawAmount)();
		
		balances[msg.sender] = 0;
	}
	
	function getBalance() constant public returns (uint){
		return this.balance;
	}
	
	function contribute() payable public {
		balances[msg.sender] += msg.value;
	}
	
	function() payable public {
		
	}
}

contract TypicalWallet{
	
	DAOFundraiser fundraiser;
	//uint r = 10;
	
	function TypicalWallet(address fundraiserAddress) public {
		fundraiser = DAOFundraiser(fundraiserAddress);
	}
	
	function contribute(uint amount) public {
		fundraiser.contribute.value(amount)();
	}
	
	function withdraw() public {
		fundraiser.withdrawAllMyCoins();
	}
	
	function getBalance() constant public returns (uint){
		return this.balance;
	}
	
	function payout() payable public{
	    
	}
	
	function() payable public{
		
	}
}