pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";

contract LendingPool {
    mapping(address => uint256) public depositedBalances;
    mapping(address => uint256) public interestEarned;

    function deposit(uint256 _amount, ERC20 _token) public {
        depositedBalances[msg.sender] += _amount;
        // Transfer tokens from user to LendingPool contract
        _token.transferFrom(msg.sender, address(this), _amount);
    }

    function withdraw(uint256 _amount, ERC20 _token) public {
        depositedBalances[msg.sender] -= _amount;
        // Transfer tokens from LendingPool contract to user
        _token.transfer(msg.sender, _amount);
    }

    function getInterestEarned(address _user) public view returns (uint256) {
        return interestEarned[_user];
    }

    function withdrawInterest(uint256 _amount, ERC20 _token) public {
        interestEarned[msg.sender] -= _amount;
        // Transfer tokens from LendingPool contract to user
        _token.transfer(msg.sender, _amount);
    }
}
