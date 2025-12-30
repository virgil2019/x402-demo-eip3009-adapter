// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import "forge-std/Script.sol";
import "../src/Wrapper.sol";

contract WrapperDeploy is Script {
    function run() public {
        uint256 deployer = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployer);
        Wrapper wrapper = new Wrapper(
        );
        wrapper.setTokenAddress(vm.envAddress("REAL_TOKEN_ADDRESS"));
        vm.stopBroadcast();
        console.logAddress(address(wrapper));
    }
}
