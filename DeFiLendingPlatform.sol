pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "./LendingPool.sol";

contract DeFiLendingPlatform {
    address public lendingPoolAddress;
    ERC20 public lsdToken;

    constructor(address _lendingPoolAddress, address _lsdToken) {
        lendingPoolAddress = _lendingPoolAddress;
        lsdToken = ERC20(_lsdToken);
    }

    function depositLSD(uint256 _amount) public {
        LendingPool(lendingPoolAddress).deposit(_amount, lsdToken);
    }

    function withdrawLSD(uint256 _amount) public {
        LendingPool(lendingPoolAddress).withdraw(_amount, lsdToken);
    }

    function getLSDBalance() public view returns (uint256) {
        return lsdToken.balanceOf(address(this));
    }

    function redeemYield() public {
        uint256 interestEarned = LendingPool(lendingPoolAddress).getInterestEarned(address(this));
        LendingPool(lendingPoolAddress).withdrawInterest(interestEarned, lsdToken);
        lsdToken.transfer(msg.sender, interestEarned);
    }
}
