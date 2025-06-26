// SPDX-Lincense-Identifier: MIT
pragma solidity ^0.8.27;

import {Test} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken private token;
    address private owner = vm.addr(1);
    address private nonOwner = vm.addr(2);

    function setUp() public {
        token = new MyToken(owner);
        vm.deal(owner, 100 ether); // Give owner some ether for testing
    }

    function testMint() public {
        vm.startPrank(owner);
        uint256 mintAmount = 50 ether;
        token.mint(mintAmount);
        assertEq(token.balanceOf(owner), mintAmount);
        vm.stopPrank();
    }

    function testMintRevertsForNonOwner() public {
        vm.startPrank(nonOwner);
        uint256 mintAmount = 50 ether;
        vm.expectRevert();
        token.mint(mintAmount);
        vm.stopPrank();

        assertEq(token.balanceOf(nonOwner), 0 ether);
    }

    function testBurn() public {
        vm.startPrank(owner);
        uint256 mintAmount = 50 ether;
        token.mint(mintAmount); // Mint some tokens first
        uint256 burnAmount = 20 ether;
        token.burn(burnAmount);
        assertEq(token.balanceOf(owner), mintAmount - burnAmount);
        vm.stopPrank();
    }

    function testBurnRevertsForNonOwner() public {
        vm.startPrank(nonOwner);
        uint256 burnAmount = 20 ether;
        vm.expectRevert();
        token.burn(burnAmount);
        vm.stopPrank();
    }
}
