pragma solidity ^0.4.10; 

contract corporateVotingDapp {

  // We use the struct datatype to store the electorate information.
  struct electorate {
    address electorateAdd; // The address of the electorate
    uint coinsBought;    // The total no. of coins this electorate owns
    uint[] coinsUsedPerNominee; // Array to keep track of votes per Nominee.
    
    /* We have an array of Nominees initialized below.
     Every time this electorate votes with her coins, the value at that
     index is incremented. Example, if NomineeList array declared
     below has ["Tom", "Dick", "Harry"] and this
     electorate votes 10 coins to Dick, the coinsUsedPerNominee[1]
     will be incremented by 10.
     */
     
  }

  /* mapping is equivalent to an associate array or hash
   The key of the mapping is Nominee name stored as type bytes32 and value is
   an unsigned integer which used to store the vote count
   */

  mapping (address => electorate) public electorateInfo;

  /* Solidity do not let us return an array of strings yet. 
   We will use an array of bytes32
   instead to store the list of Nominees
   */

  mapping (bytes32 => uint) public votesReceived;

  bytes32[] public NomineeList;

  uint public totalcoins; // Total no. of coins available for this election
  uint public balancecoins; // Total no. of coins still available for purchase
  uint public coinPrice; // Price per coin

  /* When the contract is deployed on the blockchain, we will initialize
   the total number of coins for sale, cost per coin and all the Nominees
   */
  function corporateVotingDapp(uint coins, uint pricePercoin, bytes32[] NomineeNames) public {
    NomineeList = NomineeNames;
    totalcoins = coins;
    balancecoins = coins;
    coinPrice = pricePercoin;
  }

  function totalVotesFor(bytes32 Nominee) public constant returns (uint) {
    return votesReceived[Nominee];
  }

  /* Instead of just taking the Nominee name as an argument, we now also
   require the no. of coins this electorate wants to vote for the Nominee
   */
  function voteForNominee(bytes32 Nominee, uint votesIncoins) public {
    uint index = indexOfNominee(Nominee);
    if (index == uint(-1)) revert();

    // msg.sender gives us the address of the account/electorate who is trying
    // to call this function
    if (electorateInfo[msg.sender].coinsUsedPerNominee.length == 0) {
      for(uint i = 0; i < NomineeList.length; i++) {
        electorateInfo[msg.sender].coinsUsedPerNominee.push(0);
      }
    }

    // Make sure this electorate has enough coins to cast the vote
    uint availablecoins = electorateInfo[msg.sender].coinsBought - totalcoinsUsed(electorateInfo[msg.sender].coinsUsedPerNominee);
    if (availablecoins < votesIncoins) revert();

    votesReceived[Nominee] += votesIncoins;

    // Store how many coins were used for this Nominee
    electorateInfo[msg.sender].coinsUsedPerNominee[index] += votesIncoins;
  }

  // Return the sum of all the coins used by this electorate.
  function totalcoinsUsed(uint[] _coinsUsedPerNominee) private pure returns (uint) {
    uint totalUsedcoins = 0;
    for(uint i = 0; i < _coinsUsedPerNominee.length; i++) {
      totalUsedcoins += _coinsUsedPerNominee[i];
    }
    return totalUsedcoins;
  }

  function indexOfNominee(bytes32 Nominee) public constant returns (uint) {
    for(uint i = 0; i < NomineeList.length; i++) {
      if (NomineeList[i] == Nominee) {
        return i;
      }
    }
    return uint(-1);
  }

  /* This function is used to purchase the coins. By just adding that one keyword to a function, 
  our contract can now accept Ether from anyone who calls this function.
   */

  function buy() payable public returns (uint) {
    uint coinsToBuy = msg.value / coinPrice;
    if (coinsToBuy > balancecoins) revert();
    electorateInfo[msg.sender].electorateAdd = msg.sender;
    electorateInfo[msg.sender].coinsBought += coinsToBuy;
    balancecoins -= coinsToBuy;
    return coinsToBuy;
  }

  function coinsSold() public constant returns (uint) {
    return totalcoins - balancecoins;
  }

  function electorateDetails(address user) public constant returns (uint, uint[]) {
    return (electorateInfo[user].coinsBought, electorateInfo[user].coinsUsedPerNominee);
  }

  /* All the ether sent by electorates who purchased the coins is in this
   contract's account. This method will be used to transfer out all those ethers
   in to another account. *** The way this function is written currently, anyone can call
   this method and transfer the balance in to their account. In reality, you should add
   check to make sure only the owner of this contract can cash out.
   */

  function transferTo(address account) public {
    account.transfer(this.balance);
  }

  function allNominees() public constant returns (bytes32[]) {
    return NomineeList;
  }

}