// SPDX-License-Identifier : MIT

  pragma solidity ^0.8.17;

  import "./admin.sol";
  import "./bridgeTokenInterface.sol";

   contract JohnBridge is Jagaban{
    event TokenReceived(address, address, uint256);
    
    bool bridgeOn = true;

    mapping(address => bool) bridgeable;
    mapping(address => bool) admins;

    constructor() {
        _owner = msg.sender;
        admin[msg.sender] = true;
    }

    function addToken(address _token) external {
        bridgeable[_token] = true;
    }

    function removeToken(address _token) external {
        bridgeable[_token] = false;
    }

    function bridgeStatus(bool _status) external onlyOwner{
        bridgeOn = _status;
    }

function bridgeReceive(address _token, uint amount, address _to) onlyAdmin external {
    if (bridgeable[_token] == true) {
        IBridgeToken token = IBridgeToken(_token);
        token.ownerMint(msg.sender, amount);
    }

    revert ("Cannot bridge token");
}

function bridgeSent(address _token, uint amount, address _to) onlyAdmin external {
    if (bridgeable[_token] == true) {
        IBridgeToken token = IBridgeToken(_token);
        token.ownerBurn(msg.sender, amount);
    }

    revert ("Cannot bridge token");
}
   }
