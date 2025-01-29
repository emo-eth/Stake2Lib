// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface MockStake2 {

    function getAvailableUnfreezeV2Size(address target) external view returns (uint256);
    function getUnfreezableBalanceV2(address target, Stake2Lib.ResourceType resourceType)
        external
        view
        returns (uint256);
    function getExpireUnfreezeBalanceV2(address target, uint256 timestamp)
        external
        view
        returns (uint256);
    function getDelegatableResource(address target, Stake2Lib.ResourceType resourceType)
        external
        view
        returns (uint256);
    function getResourceV2(address target, address from, Stake2Lib.ResourceType resourceType)
        external
        view
        returns (uint256);
    function checkUnDelegateResource(
        address target,
        uint256 amount,
        Stake2Lib.ResourceType resourceType
    ) external view returns (uint256 available, uint256 used, uint256 restoreTime);
    function getResourceUsage(address target, Stake2Lib.ResourceType resourceType)
        external
        view
        returns (uint256 used, uint256 restoreTime);
    function getTotalResource(address target, Stake2Lib.ResourceType resourceType)
        external
        view
        returns (uint256);
    function getTotalDelegatedResource(address target, Stake2Lib.ResourceType resourceType)
        external
        view
        returns (uint256);
    function getTotalAcquiredResource(address target, Stake2Lib.ResourceType resourceType)
        external
        view
        returns (uint256);

    function rewardBalance() external view returns (uint256);
    function isSrCandidate_(address sr) external view returns (bool);
    function voteCount(address from, address to) external view returns (uint256);
    function usedVoteCount(address owner) external view returns (uint256);
    function receivedVoteCount(address owner) external view returns (uint256);
    function totalVoteCount(address owner) external view returns (uint256);
    function withdrawReward() external returns (uint256);

}
/**
 * @title StakeLib2
 * @author emo.eth
 * @notice Library for mocking Tron's Stake 2.0 Solidity api in a real dev env.
 *         Uncomment function body when deploying to a Tron VM network.
 */

library Stake2Lib {

    /**
     * Computed using: keccak(abi.encode(uint256(keccak(Stake2Lib.storage)) - 1)) &
     * ~bytes32(uint256(0xff))
     */
    bytes32 constant STAKE2LIB_STORAGE_SLOT =
        0x4b5daa9784b369c36d4d8393af0e99d25a3781c5d4b5e98e2b84c4e2c5e30800;

    ///@custom:storage-location erc7201:Stake2Lib
    struct Stake2LibStorage {
        MockStake2 stake2;
    }

    function getStorage() private pure returns (Stake2LibStorage storage) {
        Stake2LibStorage storage $;
        assembly {
            $.slot := STAKE2LIB_STORAGE_SLOT
        }
        return $;
    }

    function getStake2() private view returns (MockStake2) {
        return getStorage().stake2;
    }

    event FreezeBalanceV2(uint256 amount, ResourceType resourceType);
    event UnfreezeBalanceV2(uint256 amount, ResourceType resourceType);
    event CancelAllUnfreezeV2();
    event WithdrawExpireUnfreeze();
    event DelegateResource(address indexed delegatee, uint256 amount, ResourceType resourceType);
    event UnDelegateResource(address indexed delegatee, uint256 amount, ResourceType resourceType);
    event Vote(address[] srList, uint256[] tpList);

    enum ResourceType {
        BANDWIDTH,
        ENERGY
    }

    function freezeBalanceV2(uint256 amount, ResourceType resourceType) internal {
        ///@custom:tron
        // freezebalancev2(amount, uint256(resourceType));
        ///@custom:forge
        emit FreezeBalanceV2(amount, resourceType);
    }

    function unfreezeBalanceV2(uint256 amount, ResourceType resourceType) internal {
        ///@custom:tron
        // unfreezebalancev2(amount, uint256(resourceType));
        ///@custom:forge
        emit UnfreezeBalanceV2(amount, resourceType);
    }

    function cancelAllUnfreezev2() internal {
        ///@custom:tron
        // cancelallunfreezev2();
        ///@custom:forge
        emit CancelAllUnfreezeV2();
    }

    function withdrawExpireUnfreeze() internal {
        ///@custom:tron
        // withdrawexpireunfreeze();
        ///@custom:forge
        emit WithdrawExpireUnfreeze();
    }

    function delegateResource(address payable delegatee, uint256 amount, ResourceType resourceType)
        internal
    {
        ///@custom:tron
        // delegatee.delegateResource(amount, uint256(resourceType));
        ///@custom:forge
        emit DelegateResource(delegatee, amount, resourceType);
    }

    function unDelegateResource(
        address payable delegatee,
        uint256 amount,
        ResourceType resourceType
    ) internal {
        ///@custom:tron
        // delegatee.unDelegateResource(amount, uint256(resourceType));
        ///@custom:forge
        emit UnDelegateResource(delegatee, amount, resourceType);
    }

    function getAvailableUnfreezeV2Size(address target) internal view returns (uint256) {
        ///@custom:tron
        // return target.availableUnfreezeV2Size();
        ///@custom:forge
        return getStake2().getAvailableUnfreezeV2Size(target);
    }

    function getUnfreezableBalanceV2(address target, ResourceType resourceType)
        internal
        view
        returns (uint256)
    {
        ///@custom:tron
        // return target.unfreezableBalanceV2(uint256(resourceType));
        ///@custom:forge
        return getStake2().getUnfreezableBalanceV2(target, resourceType);
    }

    function getExpireUnfreezeBalanceV2(address target, uint256 timestamp)
        internal
        view
        returns (uint256)
    {
        ///@custom:tron
        // return target.expireUnfreezeBalanceV2(timestamp);
        ///@custom:forge
        return getStake2().getExpireUnfreezeBalanceV2(target, timestamp);
    }

    function getDelegatableResource(address target, ResourceType resourceType)
        internal
        view
        returns (uint256)
    {
        ///@custom:tron
        // return target.delegatableResource(uint256(resourceType));
        ///@custom:forge
        return getStake2().getDelegatableResource(target, resourceType);
    }

    function getResourceV2(address target, address from, ResourceType resourceType)
        internal
        view
        returns (uint256)
    {
        ///@custom:tron
        // return target.resourceV2(from, uint256(resourceType));
        ///@custom:forge
        return getStake2().getResourceV2(target, from, resourceType);
    }

    function checkUnDelegateResource(address target, uint256 amount, ResourceType resourceType)
        internal
        view
        returns (uint256 available, uint256 used, uint256 restoreTime)
    {
        ///@custom:tron
        // return target.checkUnDelegateResource(amount, uint256(resourceType));
        ///@custom:forge
        return getStake2().checkUnDelegateResource(target, amount, resourceType);
    }

    function getResourceUsage(address target, ResourceType resourceType)
        internal
        view
        returns (uint256 used, uint256 restoreTime)
    {
        ///@custom:tron
        // return target.resourceUsage(uint256(resourceType));
        ///@custom:forge
        return getStake2().getResourceUsage(target, resourceType);
    }

    function getTotalResource(address target, ResourceType resourceType)
        internal
        view
        returns (uint256)
    {
        ///@custom:tron
        // return target.totalResource(uint256(resourceType));
        ///@custom:forge
        return getStake2().getTotalResource(target, resourceType);
    }

    function getTotalDelegatedResource(address target, ResourceType resourceType)
        internal
        view
        returns (uint256)
    {
        ///@custom:tron
        // return target.totalDelegatedResource(uint256(resourceType));
        ///@custom:forge
        return getStake2().getTotalDelegatedResource(target, resourceType);
    }

    function getTotalAcquiredResource(address target, ResourceType resourceType)
        internal
        view
        returns (uint256)
    {
        ///@custom:tron
        // return target.totalAcquiredResource(uint256(resourceType));
        ///@custom:forge
        return getStake2().getTotalAcquiredResource(target, resourceType);
    }

    function vote_(address[] memory srList, uint256[] memory tpList) internal {
        // vote(srList, tpList);
        emit Vote(srList, tpList);
    }

    function withdrawReward() internal returns (uint256) {
        ///@custom:tron
        // return withdrawreward();
        ///@custom:forge
        return getStake2().withdrawReward();
    }

    function getRewardBalance() internal view returns (uint256) {
        ///@custom:tron
        // return rewardBalance();
        ///@custom:forge
        return getStake2().rewardBalance();
    }

    function isSrCandidate_(address sr) internal view returns (bool) {
        ///@custom:tron
        // return isSrCandidate(sr);
        ///@custom:forge
        return getStake2().isSrCandidate_(sr);
    }

    function getVoteCount(address from, address to) internal view returns (uint256) {
        ///@custom:tron
        // return voteCount(from, to);
        ///@custom:forge
        return getStake2().voteCount(from, to);
    }

    function getUsedVoteCount(address owner) internal view returns (uint256) {
        ///@custom:tron
        // return usedVoteCount(owner);
        ///@custom:forge
        return getStake2().usedVoteCount(owner);
    }

    function getReceivedVoteCount(address owner) internal view returns (uint256) {
        ///@custom:tron
        // return receivedVoteCount(owner);
        ///@custom:forge
        return getStake2().receivedVoteCount(owner);
    }

    function getTotalVoteCount(address owner) internal view returns (uint256) {
        ///@custom:tron
        // return totalVoteCount(owner);
        ///@custom:forge
        return getStake2().totalVoteCount(owner);
    }

}
