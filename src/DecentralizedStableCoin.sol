// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
// Collateral; Exogenous(ETH and BTC)

contract DecentralizedStableCoin is ERC20Burnable {
    constructor() ERC20("Decentralized Stable Coin", "DSC") {
        // Initialization code if needed
    }
}
