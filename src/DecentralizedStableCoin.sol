// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC20Burnable, ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
// Collateral; Exogenous(ETH and BTC)

contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    error DecentralizedStableCoin__InvalidAmount();
    error DecentralizedStableCoin__InsufficientBalance();

    constructor() ERC20("DecentralizedStableCoin", "DSC") {
        // Initialization code if needed
    }

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if (_amount <= 0) revert DecentralizedStableCoin__InvalidAmount();
        if (_amount > balance) revert DecentralizedStableCoin__InsufficientBalance();
        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        if (_to == address(0)) revert DecentralizedStableCoin__InvalidAmount();
        if (_amount <= 0) revert DecentralizedStableCoin__InvalidAmount();
        _mint(_to, _amount);
    }
}
