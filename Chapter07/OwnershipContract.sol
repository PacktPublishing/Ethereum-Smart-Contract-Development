pragma solidity ^0.4.19;
contract OwnershipContract 
{ 
    struct FileMapping 
    { 
        uint timestamp; 
        string owner; 
    } 

    mapping (string => FileMapping) files; 

    event FileLogStatus(bool status, uint timestamp, string owner, string fileHash); 

    //Used to store the owner of file at the block timestamp 
    function set(string owner, string fileHash) public
    { 
        //Here we are checking for default value i.e., all bits are 0 
        if(files[fileHash].timestamp == 0) 
        { 
            files[fileHash] = FileMapping(block.timestamp, owner); 

            //triggering an event to notify the frontend 
            FileLogStatus(true, block.timestamp, owner, fileHash); 
        } 
        else 
        { 
            //returning out a false status to the frontend 
            FileLogStatus(false, block.timestamp, owner, fileHash); 
        } 
    } 

    //this is used to get file information 
    function get(string fileHash) internal view returns (uint timestamp, string owner) 
    { 
        return (files[fileHash].timestamp, files[fileHash].owner); 
    } 
} 