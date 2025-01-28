// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { Stake2Lib } from "./Stake2Lib.sol";

/**
 * Stake2Lib
 * @title Delegator
 * @author emo.eth
 * @notice Example contract for interfacing with Stake2Lib.
 */
contract ExampleDelegator {

    // use Solidity `using` syntax to mimic Tron's Solidity API
    using Stake2Lib for address payable;

    function delegate(
        address payable delegatee,
        uint256 amount,
        Stake2Lib.ResourceType resourceType
    ) external {
        delegatee.delegateResource(amount, resourceType);
    }

    function unDelegate(
        address payable delegatee,
        uint256 amount,
        Stake2Lib.ResourceType resourceType
    ) external {
        delegatee.unDelegateResource(amount, resourceType);
    }

    function freezeBalance(uint256 amount, Stake2Lib.ResourceType resourceType) external {
        Stake2Lib.freezeBalanceV2(amount, resourceType);
    }

    function unfreezeBalance(uint256 amount, Stake2Lib.ResourceType resourceType) external {
        Stake2Lib.unfreezeBalanceV2(amount, resourceType);
    }

    receive() external payable { }

}
