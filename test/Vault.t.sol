//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/vault.sol";

contract VaultTest is Test {
    Vault public vault;
    address user = makeAddr("user");

    function setUp() public {
        vault = new Vault();
        vm.deal(user, 10 ether);
    }

    function test_Deposit() public {
        vm.prank(user);
        vault.deposit{value: 1 ether}();
        assertEq(vault.balances(user), 1 ether);
    }

    function test_withdraw() public {
        vm.startPrank(user);
        // This function is just a placeholder to illustrate the test case.
        // Actual withdrawal logic is implemented in the withdraw function above.
        vault.deposit{value: 2 ether}();

        vault.withdraw(1 ether);
        vm.stopPrank();
        assertEq(vault.balances(user), 1 ether);
    }

    function test_RevertWidhdraw() public {
        vm.startPrank(user);
        vault.deposit{value: 1 ether}();
        vm.expectRevert("Insufficient balance");
        vault.withdraw(2 ether);
        vm.stopPrank();
    }

    function test_getBalance() public {
        vm.startPrank(user);
        vault.deposit{value: 0.5 ether}();
        uint256 balance = vault.getBalance();
        vm.stopPrank();
        assertEq(balance, 0.5 ether);
    }
}
