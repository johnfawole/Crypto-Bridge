// SPDX-License-Identifier : MIT

   pragma solidity ^0.8.17;

  import "./admin.sol";

   contract BridgeToken is Jagaban{
     
     constructor() public {
         _name = "Bridge Token";
         _symbol = "BRTK";
         _decimals = 18;
         _owner = msg.sender;
         admin[msg.sender] = true;
     }

     mapping(address => uint256) balanceOf;
     mapping(address => mapping(address => uint)) _allowed;

     string _name;
     string _symbol;
     uint _decimals;
     uint _maxSupply;
     uint _totalSupply;

     function getName() public view returns (string memory) {
         return _name;
     }

     function Getsymbol() public view returns(string memory) {
         return _symbol;
     }

     function Getdecimals() public view returns(uint) {
         return _decimals;
     }

     function maxSupply() public view returns(uint) {
         return _maxSupply;
     }

     function totalSupply() public view returns(uint) {
         return _totalSupply;
     }

     function getOwner() public view returns(address){
       return _owner;
     }

     function remainingTokens() public view returns(uint){
         uint result = _maxSupply - _totalSupply;
         return result;
     }

     function setMaxSupply(uint amount) external onlyOwner returns (bool){
         _maxSupply = amount;
         return true;
     }
     
     function transferOwnership(address _address) external onlyOwner returns (bool) {
       _owner = _address;
       return true;
     }

    function ownerMint(address to, uint amount) external onlyAdmin returns (bool) {
        require(_totalSupply > _maxSupply, "Max cannot be more than total");
        _mint(to, amount);
        return true;
    }

    function ownerBurn(address from, uint amount) external onlyAdmin returns (bool) {
        _burn(from, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint) {
        return _allowed[owner][spender];
    }

    function transfer(address to, uint value) public returns (bool) {
      require(value <= balanceOf[msg.sender], "you must have enough balance");
      require(to != address(0), "you cannot be an address zero");
      
      balanceOf[msg.sender] = balanceOf[msg.sender] - value;
      balanceOf[to] = balanceOf[to] + value;

      return true;
    }

    function approve(address spender, uint value) public returns (bool) {
      require(spender != address(0), "cannot allow address 0");

      _allowed[msg.sender][spender] = value;
      return true;
    }

    function transferFrom(address from, address to, uint value) public returns (bool) {
        require(value <= balanceOf[from], "Must have enough balance");
        require(value <= _allowed[from][msg.sender], "Not allowed");
        
        balanceOf[from] = balanceOf[from] - value;
        balanceOf[to] = balanceOf[to] + value;
        _allowed[from][msg.sender] = _allowed[from][msg.sender] - value;

        return true;
    }

    function increaseAllowance(address spender, uint subtractedValue) public returns (bool) {
        require(spender != address(0), "you cannot allow an address 0");

        _allowed[msg.sender][spender] = _allowed[msg.sender][spender] + subtractedValue;

        return true;
    } 

    function _mint (address _address, uint amount) internal {
        require(_address != address(0), "cannot mint into an address 0");

        _totalSupply = _totalSupply + amount;
        balanceOf[_address] = balanceOf[_address] + amount; 
    }

    function _burn (address _address, uint amount) internal {
        require(_address != address(0), "cannot mint into an address 0");
        require(amount <= balanceOf[_address], "Insufficient balance to burn");

        _totalSupply = _totalSupply - amount;
        balanceOf[_address] = balanceOf[_address] - amount; 
    }
    }
