// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { EIP3009 } from "./EIP3009.sol";
import { IERC20 } from "./interface/IERC20.sol";
import { EIP712 } from "./util/EIP712.sol";

contract Wrapper is EIP3009 {
    address public realToken;

    constructor(string memory tokenName, string memory tokenVersion) {
        _DEPRECATED_CACHED_DOMAIN_SEPARATOR = EIP712.makeDomainSeparator(
            tokenName,
            tokenVersion
        );        
    }

    function setTokenAddress(address newTokenAddress) public {
        realToken = newTokenAddress;
    }

    function transferWithAuthorization(
        address from,
        address to,
        uint256 value,
        uint256 validAfter,
        uint256 validBefore,
        bytes32 nonce,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public {
        _transferWithAuthorization(from, to, value, validAfter, validBefore, nonce, v, r, s);
    }

    function _transfer(address from, address to, uint256 value) internal override {
        IERC20(realToken).transferFrom(from, to, value);
    }
}
