// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 * @title StakeLib2
 * @author emo.eth
 * @notice Library for mocking Tron's Stake 2.0 Solidity api in a real dev env.
 *         Uncomment function body when deploying to a Tron VM network.
 */
library Stake2Lib {

    enum ResourceType {
        BANDWIDTH,
        ENERGY
    }

    function freezeBalanceV2(uint256 amount, ResourceType resourceType) internal {
        // freezebalancev2(amount, uint256(resourceType));
    }

    function unfreezebalancev2(uint256 amount, ResourceType resourceType) internal {
        // unfreezebalancev2(amount, uint256(resourceType));
    }

    function cancelallunfreezev2() internal {
        // cancelallunfreezev2();
    }

    function withdrawexpireunfreeze() internal {
        // withdrawexpireunfreeze();
    }

    function delegateResource(address payable delegatee, uint256 amount, ResourceType resourceType)
        internal
    {
        // delegatee.delegateResource(amount, uint256(resourceType));
    }

    function unDelegateResource(
        address payable delegatee,
        uint256 amount,
        ResourceType resourceType
    ) internal {
        // delegatee.unDelegateResource(amount, uint256(resourceType));
    }

}
