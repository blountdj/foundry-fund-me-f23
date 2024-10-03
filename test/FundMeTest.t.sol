// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// console allows console.log
import {Test, console} from "forge-std/Test.sol"; 
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {

    uint256 number = 1;
    FundMe fundMe;

    function setUp() external {
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    function testDemo() public {
        assertEq(number, 2);
    }

    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        // assertEq(fundMe.i_owner(), address(this)); // not msg.sender because FundMeTest deploys the FundMe contract
        assertEq(fundMe.i_owner(), msg.sender); // not msg.sender because FundMeTest deploys the FundMe contract
    }

    function testPriceFeedVersionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }
}