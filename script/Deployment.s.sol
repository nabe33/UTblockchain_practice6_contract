// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Counter.sol";

contract Deployment is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        string memory deployerPrivateKeyHex = vm.envString("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        Counter c = new Counter();

        vm.stopBroadcast();

        bytes memory encodedData = abi.encodePacked("deployed address: ", vm.toString(address(c)));
        console.log(string(encodedData));
        console.log("Private key: ", deployerPrivateKeyHex);
    }
}
