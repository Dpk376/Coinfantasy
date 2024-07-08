pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "./Lido.sol";
import "./DeFiLendingPlatform.sol";

contract LidoLiquidStaking {
    address public lidoAddress;
    ERC20 public lsdToken;
    ERC20 public erc20Token;
    DeFiLendingPlatform public deFiLendingPlatform;

    constructor(address _lidoAddress, address _lsdToken, address _erc20Token, address _deFiLendingPlatform) {
        lidoAddress = _lidoAddress;
        lsdToken = ERC20(_lsdToken);
        erc20Token = ERC20(_erc20Token);
        deFiLendingPlatform = DeFiLendingPlatform(_deFiLendingPlatform);
    }

    function stakeTokens(uint256 _amount) public {
        Lido(lidoAddress).stake(_amount);
        // Transfer ERC-20 tokens from user to Lido contract
        erc20Token.transferFrom(msg.sender, lidoAddress, _amount);
    }

    function unstakeTokens(uint256 _amount) public {
        Lido(lidoAddress).unstake(_amount);
        // Transfer ERC-20 tokens from Lido contract to user
        erc20Token.transfer(msg.sender, _amount);
    }

    function depositLSDToDeFiLendingPlatform(uint256 _amount) public {
        lsdToken.transferFrom(msg.sender, address(this), _amount);
        deFiLendingPlatform.depositLSD(_amount);
    }

    function redeemERC20Tokens(uint256 _lsdAmount) public {
        Lido(lidoAddress).redeem(_lsdAmount, erc20Token);
        erc20Token.transfer(msg.sender, _lsdAmount);
    }

    function redeemYieldFromDeFiLendingPlatform() public {
        deFiLendingPlatform.redeemYield();
    }
}
