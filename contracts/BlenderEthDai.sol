// SPDX-License-Identificer: MIT
pragma solidity ^0.8;

contract BlenderEthDai {
    address payable owner;
    event CollateralAdded(address sender, uint value, uint balance);
    event PriceUpdated(uint previousPrice, uint newPrice);

    uint public borrow_apr = 700;
    uint public asset_price = 4000;

    mapping (address => uint256) public collateral;

    modifier onlyOwner() {
        require(msg.sender == owner, 'Not Owner');
        _;
    }

    constructor() {
        owner = payable(msg.sender);
    }

    function update_price(uint _price) public onlyOwner {
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