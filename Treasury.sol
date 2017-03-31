
pragma solidity ^0.4.9;

contract DexNS {
     function name(string) constant returns (bytes32);
     function getName(string) constant returns (address _owner, address _associated, string _value, uint _end);
     
     function ownerOf(string) constant returns (address);
     function addressOf(string) constant returns (address);
     function valueOf(string) constant returns (string);
     function endblockOf(string) constant returns (uint);
 }
 
 contract DEXToken {
  uint public totalSupply;
  function getSupply() constant returns (uint256 totalSupply);
  function balanceOf(address who) constant returns (uint);
  function allowance(address owner, address spender) constant returns (uint);

  function transfer(address to, uint value) returns (bool ok);
  function transfer(address to, uint value, bytes data) returns (bool ok);
  function transferFrom(address from, address to, uint value) returns (bool ok);
  function approve(address spender, uint value) returns (bool ok);
  event Transfer(address indexed from, address indexed to, uint value);
  event Approval(address indexed owner, address indexed spender, uint value);
  
  
  function mint(address minter, uint value) returns (bool ok);
  function burn(address burner, uint value) returns (bool ok);
}
 
 contract Treasury {
    modifier dexTokenOnly {
        if (msg.sender!=ns.addressOf("DEX token"))
            throw;
        _;
    }
    
    modifier onlyOwner {
        if (msg.sender!=owner)
            throw;
        _;
    }
    
    modifier onlyDebug {
        if (!debug)
            throw;
        _;
    }
    
    address owner;
    bool debug = true;
    address nameService = 0x0;
    DexNS ns = DexNS(nameService);
    
    //Contract is receiving funds from DApps
    //every transaction to this contract will be considered donation
    function() payable { }
    
    
    
    //Payable fallback function that will convert every incoming DEX intor Ether benefit
    function tokenFallback(address _from, uint _value, bytes _data) dexTokenOnly returns (bool result) {
        DEXToken dt = DEXToken(ns.addressOf("DEX token"));
        if(_from.send(this.balance * (_value / dt.getSupply()))) {
            dt.burn(_from, _value);
        }
    }
    
    
    
    
    function Treasury() {
        owner=msg.sender;
    }
    
    
    function dispose_ONLYDEBUG() onlyOwner onlyDebug {
        selfdestruct(owner);
    }
    
    function delegateCall(address _target, uint _gas, bytes _data) payable onlyOwner {
        _target.call.value(_gas)(_data);
    }
    
    function disableDebug_ONLYDEBUG(address _newOwner) onlyOwner onlyDebug {
        debug=false;
    }
}
