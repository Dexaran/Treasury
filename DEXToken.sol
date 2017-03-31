pragma solidity ^0.4.9;
 
contract contractReceiver{ function tokenFallback(address from, uint value, bytes data) returns (bool ok); }

contract DexNS {
     function name(string) constant returns (bytes32);
     function getName(string) constant returns (address _owner, address _associated, string _value, uint _end);
     
     function ownerOf(string) constant returns (address);
     function addressOf(string) constant returns (address);
     function valueOf(string) constant returns (string);
     function endblockOf(string) constant returns (uint);
 }

contract ERC23_mod {
  uint public totalSupply;
  function balanceOf(address who) constant returns (uint);
  function getSupply() constant returns (uint256 totalSupply);

  function transfer(address to, uint value) returns (bool ok);
  function transfer(address to, uint value, bytes data) returns (bool ok);
  event Transfer(address indexed from, address indexed to, uint value);
}
 
contract DEXToken is ERC23_mod {
    
    modifier onlyOwner {
        if (msg.sender!=owner)
            throw;
        _;
    }
    
    modifier onlyCentralMinter {
        if (msg.sender!=ns.addressOf("Central minter"))
            throw;
        _;
    }
    
    modifier onlyDebug {
        if (!debug)
            throw;
        _;
    }
    
  event Transfer(address indexed from, address indexed to, uint value);
  event Mint(address indexed minter, uint indexed value);
  event Burn(address indexed burner, uint indexed value);

  mapping(address => uint) balances;
  address nameService=0x0;
  DexNS ns = DexNS(nameService);
    bool public debug=true;
    string public name = "DEX Token";
    uint8  public decimals = 0;
    string public symbol = "DEX";
    uint public totalSupply=10000;
    address public owner;
    uint public eraSize=20;
    uint public eraReward=25;
    uint public remainingTokens=0;
    uint public currentEra=0;
  
  function DEXToken()
  {
      owner=msg.sender;
      balances[msg.sender]=10000;
  }
    
    
  function getSupply() constant returns (uint256 _supply) {
        return totalSupply;
  }    

  //function that is called when a user or another contract wants to transfer funds
  function transfer(address _to, uint _value, bytes _data) returns (bool success) {
    //filtering if the target is a contract with bytecode inside it
    if(isContract(_to)) {
        transferToContract(_to, _value, _data);
    }
    else {
        transferToAddress(_to, _value, _data);
    }
    return true;
  }
  
  function transfer(address _to, uint _value) returns (bool success) {
      
    //standard function transfer similar to ERC20 transfer with no _data
    //added due to backwards compatibility reasons
    bytes emptyData;
    if(isContract(_to)) {
        transferToContract(_to, _value, emptyData);
    }
    else {
        transferToAddress(_to, _value, emptyData);
    }
    return true;
  }

  //function that is called when transaction target is an address
  function transferToAddress(address _to, uint _value, bytes _data) private returns (bool success) {
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    Transfer(msg.sender, _to, _value);
    return true;
  }
  
  //function that is called when transaction target is a contract
  function transferToContract(address _to, uint _value, bytes _data) private returns (bool success) {
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    contractReceiver reciever = contractReceiver(_to);
    reciever.tokenFallback(msg.sender, _value, _data);
    Transfer(msg.sender, _to, _value);
    return true;
  }
  
  //assemble the given address bytecode. If bytecode exists then the _addr is a contract.
  function isContract(address _addr) private returns (bool is_contract) {
      uint length;
      assembly {
            length := extcodesize(_addr)
        }
        if(length>0) {
            return true;
        }
        else {
            return false;
        }
    }

  function balanceOf(address _owner) constant returns (uint balance) {
    return balances[_owner];
  }
  
  //Central Minter can perform 25 tokens minting every 2000 blocks.
  function mintToken(address _minter, uint _amount) onlyCentralMinter returns (bool result) {
     //Refresh era if 2000 blocks already passes
     if(currentEra < block.number/eraSize) {
         currentEra = block.number/eraSize;
         remainingTokens = eraReward; //Forget about unclaimed tokens.
     }
     
    if(remainingTokens >= _amount) {
        balances[_minter] += _amount;
        totalSupply += _amount;
        remainingTokens -= _amount;
        Mint(_minter, _amount);
        return true;
    }
    return false;
  }
  
  function burnToken(address _burner, uint _amount) onlyCentralMinter returns (bool result) {
      if(balances[_burner] >= _amount) {
        balances[_burner] -= _amount;
        totalSupply -= _amount;
        Burn(_burner, _amount);
        return true;
      }
      return false;
  }
  
  
  
  //DEBUG functions
    
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
