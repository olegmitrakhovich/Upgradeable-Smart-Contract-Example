pragma solidity 0.8.11;

import "./storage.sol";

contract Proxy is Storage {

    address currentAddress;

    //modifier onlyOwner(){
    //    require(owner == msg.sender);
    //    _;

    //}

    constructor(address _address){
        owner = msg.sender;
        currentAddress = _address;
    }

    function upgradeCurrentAddress(address _address) public onlyOwner{
        currentAddress = _address;
    }

    fallback() external payable{
        address implementation = currentAddress;
        require(implementation != address(0));
        bytes memory data = msg.data;

        assembly {
            let result := delegatecall(gas(), implementation, add(data, 0x20), mload(data), 0, 0)
            let size := returndatasize()
            let ptr := mload(0x40)
            returndatacopy(ptr, 0, size)
            switch result
            case 0 {revert(ptr, size)}
            default {return(ptr, size)} 
        }
    }
}