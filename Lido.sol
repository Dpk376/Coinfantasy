pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";

contract Lido {
    mapping(address => uint256) public stakedBalances;
    mapping(address => uint256) public lsdBalances;

    function stake(uint256 _amount) public {
        stakedBalances[msg.sender] += _amount;
        // Transfer ERC-20 tokens from user to Lido contract
        ERC20 erc20Token = ERC20(0x...); // Replace with ERC-20 token address
        erc20Token.transferFrom(msg.sender, address(this), _amount);
    }

    function unstake(uint256 _amount) public {
        stakedBalances[msg.sender] -= _amount;
        // Transfer ERC-20 tokens from Lido contract to user
        ERC20 erc20Token = ERC20(0x...); // Replace with ERC-20 token address
        erc20Token.transfer(msg.sender, _amount);
    }

    function redeem(uint256 _lsdAmount, ERC20 _erc20Token) public {
        lsdBalances[msg.sender] -= _lsdAmount;
        // Transfer ERC-20 tokens from Lido contract to user
        _erc20Token.transfer(msg.sender, _lsdAmount);
    }

    function getStakedBalance(address _user) public view returns (uint256) {
        return stakedBalances[_user];
    }

    function getLSDBalance(address _user) public view returns (uint256) {
        return lsdBalances[_user];
    }
}
