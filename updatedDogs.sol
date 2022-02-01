pragma solidity ^0.8.11;

import "./storage.sol";

contract updateDogs is Storage  {
    
    //modifier onlyOwner(){
    //    require(msg.sender == owner);
    //    _;
    //}

    //constructor(){
    //    owner = msg.sender;
    //}

    function getNumberOfDogs() public view returns(uint256){
        return _uintStorage["Dogs"];
    }

     //probably will work better as set uint mapping
     //onlyOwner should call this function
    function setNumberOfDogs(uint256 number) public onlyOwner {
          _uintStorage["Dogs"] = number + 1;
    }
}