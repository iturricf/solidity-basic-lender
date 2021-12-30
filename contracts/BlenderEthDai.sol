// SPDX-License-Identificer: MIT
pragma solidity ^0.8;

contract BlenderEthDai {
    address payable owner;
    event CollateralAdded(address sender, uint value, uint balance);
    event PriceUpdated(uint previousPrice, uint newPrice);

    uint borrow_apr = 700;
    uint public asset_price = 4000;

    mapping (address => uint256) public collateral;

    constructor() {
        owner = payable(msg.sender);
    }

    function update_price(uint _price) public {
        require(msg.sender == owner);
        uint previousPrice = asset_price;
        asset_price = _price;
        emit PriceUpdated(previousPrice, asset_price);
    }

    function add_collateral() payable public {
        collateral[msg.sender] += msg.value;
        emit CollateralAdded(msg.sender, msg.value, address(this).balance);
    }

    // function borrow(uint256 _amount) public {
    //     //
    // }
}