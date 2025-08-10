//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {DecentralizedStableCoin} from "./DecentralizedStableCoin.sol";
import {ReentrancyGuard} from "lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract DSCEngine is ReentrancyGuard {

  error DecentralizedStableCoin__InvalidAmount() ;
  error TokenAddressesAndPriceFeedsMismatch() ;
  error DSCEngineNotAllowed() ;
  error DscEngineTransferFailed() ;

 mapping(address token => address priceFeed) private s_priceFeeds;
mapping(address user => mapping(address token => uint256 amount)) private s_collateral;

DecentralizedStableCoin private immutable i_dsc;

event CollateralDeposited(
        address indexed user,
        address indexed tokenCollateralAddress,
        uint256 collateralAmount
    );

   modifier moreThanZero(uint256 amount) {
      if(amount == 0) {
        revert DecentralizedStableCoin__InvalidAmount();
      }
      _;
   }

    modifier isAllowedToken(address token) {
      if(s_priceFeeds[token] == address(0)) {
        revert DSCEngineNotAllowed();
      }
      _;
    }
   constructor(address[] memory tokenAddresses,
               address[] memory priceFeedAddresses,
               address dscAddress) {
        if(tokenAddresses.length != priceFeedAddresses.length) {
            revert TokenAddressesAndPriceFeedsMismatch();
        }
        for(uint256 i = 0; i < tokenAddresses.length; i++) {
            s_priceFeeds[tokenAddresses[i]] = priceFeedAddresses[i];
        }
        i_dsc = DecentralizedStableCoin(dscAddress);
        }

    function depositColateralAndMintDsc() external{}
    function depositCollateral(address tokenCollateralAddress,
                              uint256 Collateralamount) external
                               moreThanZero(Collateralamount)
                               isAllowedToken(tokenCollateralAddress)
                               nonReentrant {
                                  s_collateral[msg.sender]
                                  [tokenCollateralAddress] += Collateralamount;
                               emit CollateralDeposited(msg.sender, tokenCollateralAddress, Collateralamount);
                              bool success = IERC20(tokenCollateralAddress).transferFrom(msg.sender, address(this), Collateralamount);
                              if(!success) {
                                  revert DscEngineTransferFailed();
                              }
                                }

    function redeemCollateralAndBurnDsc() external{}
    function redeemCollateral() external{}
    function mintDsc() external{}

    function liquidateCollateral() external{}

    function getCollateralValue() external view returns (uint256) {   }
    function burnDsc() external{}
    function liquidate() external{}
    function getHealthFactor() external view returns (uint256) {

   }
}