 // SPDX-License-Identifier : MIT

  pragma solidity ^0.8.17;

  // you will need this interface to mint and burn the 
  // bridge tokens when necessary

   interface IBridgeToken {
       
       function ownerMint(address to, uint amount) external returns (bool);

       function ownerBurn(address to, uint amount) external returns (bool);
   }
