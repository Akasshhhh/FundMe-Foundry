//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMe is Script {
    uint constant SEND_VALUE = 0.1 ether;
    function fundFundMe(address mostRecentlyDeployed) external {
        vm.startBroadcast();
        FundMe(mostRecentlyDeployed).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe contract with %s",SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        ); //uses the most recently deployed contract
        fundFundMe(mostRecentlyDeployed);
    }
}

contract Withdraw is Script {}
