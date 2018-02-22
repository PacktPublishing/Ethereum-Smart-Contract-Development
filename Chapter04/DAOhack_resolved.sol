pragma solidity ^0.4.11;

contract DAOFundraiser {
	
	mapping(address=>uint) balances;
	
	
	function withdrawAllMyCoins(){
		
		uint withdrawAmount = balances[msg.sender];
		// not vulnerable anymore
		balances[msg.sender] = 0;
		TypicalWallet wallet = TypicalWallet(msg.sender);
		wallet.payout.value(withdrawAmount)();
		

	}
	
	function getBalance() constant returns (uint){
		return this.balance;
	}
	
	function contribute() payable{
		balances[msg.sender] += msg.value;
	}
	
	function() payable{
		
	}
}



contract TypicalWallet{
	
	DAOFundraiser fundraiser;
	uint r= 10;
	
	function TypicalWallet(address fundraiserAddress){
		fundraiser = DAOFundraiser(fundraiserAddress);
	}
	
	function contribute(uint amount){
		fundraiser.contribute.value(amount)();
	}
	
	function withdraw(){
		fundraiser.withdrawAllMyCoins();
	}
	
	function getBalance() constant returns (uint){
		return this.balance;
	}
	
	function payout() payable{
	    // exploit
		if(r>0){
			r--;
			fundraiser.withdrawAllMyCoins();
		}
 // receive payment
 // log or do other activity
 // complex codes
	    
	}
	
	function() payable{
		
	}
}