// Datarius tokensale smart contract.
// Developed by Phenom.Team <<span class="__cf_email__" data-cfemail="b9d0d7dfd6f9c9d1dcd7d6d497cddcd8d4">[email&#160;protected]</span>>
pragma solidity ^0.4.15;

/**
 *   @title SafeMath
 *   @dev Math operations with safety checks that throw on error
 */

library SafeMath {

  function mul(uint a, uint b) internal constant returns (uint) {
    if (a == 0) {
      return 0;
    }
    uint c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint a, uint b) internal constant returns(uint) {
    assert(b > 0);
    uint c = a / b;
    assert(a == b * c + a % b);
    return c;
  }

  function sub(uint a, uint b) internal constant returns(uint) {
    assert(b <= a);
    return a - b;
  }

  function add(uint a, uint b) internal constant returns(uint) {
    uint c = a + b;
    assert(c >= a);
    return c;
  }
}

/**
 *   @title ERC20
 *   @dev Standart ERC20 token interface
 */

contract ERC20 {
    uint public totalSupply = 0;

    mapping(address => uint) balances;
    mapping(address => mapping (address => uint)) allowed;

    function balanceOf(address _owner) constant returns (uint);
    function transfer(address _to, uint _value) returns (bool);
    function transferFrom(address _from, address _to, uint _value) returns (bool);
    function approve(address _spender, uint _value) returns (bool);
    function allowance(address _owner, address _spender) constant returns (uint);

    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);

} 


/**
 *   @title DatariusToken
 *   @dev Datarius token contract
 */
contract DatariusToken is ERC20 {
    using SafeMath for uint;
    string public name = "Datarius Credit";
    string public symbol = "DTRC";
    uint public decimals = 18;

    // Ico contract address
    address public ico;
    event Burn(address indexed from, uint value);
    
    // Tokens transfer ability status
    bool public tokensAreFrozen = true;

    // Allows execution by the owner only
    modifier icoOnly { 
        require(msg.sender == ico); 
        _; 
    }

   /**
    *   @dev Contract constructor function sets Ico address
    *   @param _ico          ico address
    */
    function DatariusToken(address _ico) public {
       ico = _ico;
    }

   /**
    *   @dev Function to mint tokens
    *   @param _holder       beneficiary address the tokens will be issued to
    *   @param _value        number of tokens to issue
    */
    function mintTokens(address _holder, uint _value) external icoOnly {
       require(_value > 0);
       balances[_holder] = balances[_holder].add(_value);
       totalSupply = totalSupply.add(_value);
       Transfer(0x0, _holder, _value);
    }


   /**
    *   @dev Function to enable token transfers
    */
    function defrost() external icoOnly {
       tokensAreFrozen = false;
    }


   /**
    *   @dev Burn Tokens
    *   @param _holder       token holder address which the tokens will be burnt
    *   @param _value        number of tokens to burn
    */
    function burnTokens(address _holder, uint _value) external icoOnly {
        require(balances[_holder] > 0);
        totalSupply = totalSupply.sub(_value);
        balances[_holder] = balances[_holder].sub(_value);
        Burn(_holder, _value);
    }

   /**
    *   @dev Get balance of tokens holder
    *   @param _holder        holder's address
    *   @return               balance of investor
    */
    function balanceOf(address _holder) constant returns (uint) {
         return balances[_holder];
    }

   /**
    *   @dev Send coins
    *   throws on any error rather then return a false flag to minimize
    *   user errors
    *   @param _to           target address
    *   @param _amount       transfer amount
    *
    *   @return true if the transfer was successful
    */
    function transfer(address _to, uint _amount) public returns (bool) {
        require(!tokensAreFrozen);
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        balances[_to] = balances[_to].add(_amount);
        Transfer(msg.sender, _to, _amount);
        return true;
    }

   /**
    *   @dev An account/contract attempts to get the coins
    *   throws on any error rather then return a false flag to minimize user errors
    *
    *   @param _from         source address
    *   @param _to           target address
    *   @param _amount       transfer amount
    *
    *   @return true if the transfer was successful
    */
    function transferFrom(address _from, address _to, uint _amount) public returns (bool) {
        require(!tokensAreFrozen);
        balances[_from] = balances[_from].sub(_amount);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_amount);
        balances[_to] = balances[_to].add(_amount);
        Transfer(_from, _to, _amount);
        return true;
     }


   /**
    *   @dev Allows another account/contract to spend some tokens on its behalf
    *   throws on any error rather then return a false flag to minimize user errors
    *
    *   also, to minimize the risk of the approve/transferFrom attack vector
    *   approve has to be called twice in 2 separate transactions - once to
    *   change the allowance to 0 and secondly to change it to the new allowance
    *   value
    *
    *   @param _spender      approved address
    *   @param _amount       allowance amount
    *
    *   @return true if the approval was successful
    */
    function approve(address _spender, uint _amount) public returns (bool) {
        require((_amount == 0) || (allowed[msg.sender][_spender] == 0));
        allowed[msg.sender][_spender] = _amount;
        Approval(msg.sender, _spender, _amount);
        return true;
    }

   /**
    *   @dev Function to check the amount of tokens that an owner allowed to a spender.
    *
    *   @param _owner        the address which owns the funds
    *   @param _spender      the address which will spend the funds
    *
    *   @return              the amount of tokens still avaible for the spender
    */
    function allowance(address _owner, address _spender) constant returns (uint) {
        return allowed[_owner][_spender];
    }
}