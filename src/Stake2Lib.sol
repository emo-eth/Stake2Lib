// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

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

    function unfreezeBalanceV2(uint256 amount, ResourceType resourceType) internal {
        // unfreezebalancev2(amount, uint256(resourceType));
    }

    function cancelAllUnfreezev2() internal {
        // cancelallunfreezev2();
    }

    function withdrawExpireUnfreeze() internal {
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

    function getAvailableUnfreezeV2Size(address target) internal view returns (uint256) {
        // return target.availableUnfreezeV2Size();
    }

    function getUnfreezableBalanceV2(address target, ResourceType resourceType)
        internal
        view
        returns (uint256)
    {
        // return target.unfreezableBalanceV2(uint256(resourceType));
    }

    function getExpireUnfreezeBalanceV2(address target, uint256 timestamp)
        internal
        view
        returns (uint256)
    {
        // return target.expireUnfreezeBalanceV2(timestamp);
    }

    function getDelegatableResource(address target, ResourceType resourceType)
        internal
        view
        returns (uint256)
    {
        // return target.delegatableResource(uint256(resourceType));
    }

    function getResourceV2(address target, address from, ResourceType resourceType)
        internal
        view
        returns (uint256)
    {
        // return target.resourceV2(from, uint256(resourceType));
    }

    function checkUnDelegateResource(address target, uint256 amount, ResourceType resourceType)
        internal
        view
        returns (uint256 available, uint256 used, uint256 restoreTime)
    {
        // return target.checkUnDelegateResource(amount, uint256(resourceType));
    }

    function getResourceUsage(address target, ResourceType resourceType)
        internal
        view
        returns (uint256 used, uint256 restoreTime)
    {
        // return target.resourceUsage(uint256(resourceType));
    }

    function getTotalResource(address target, ResourceType resourceType)
        internal
        view
        returns (uint256)
    {
        // return target.totalResource(uint256(resourceType));
    }

    function getTotalDelegatedResource(address target, ResourceType resourceType)
        internal
        view
        returns (uint256)
    {
        // return target.totalDelegatedResource(uint256(resourceType));
    }

    function getTotalAcquiredResource(address target, ResourceType resourceType)
        internal
        view
        returns (uint256)
    {
        // return target.totalAcquiredResource(uint256(resourceType));
    }

    function vote_(address[] memory srList, uint256[] memory tpList) internal {
        // vote(srList, tpList);
    }

    function withdrawReward() internal returns (uint256) {
        // return withdrawreward();
    }

    function getRewardBalance() internal view returns (uint256) {
        // return rewardBalance();
    }

    function isSrCandidate_(address sr) internal view returns (bool) {
        // return isSrCandidate(sr);
    }

    function getVoteCount(address from, address to) internal view returns (uint256) {
        // return voteCount(from, to);
    }

    function getUsedVoteCount(address owner) internal view returns (uint256) {
        // return usedVoteCount(owner);
    }

    function getReceivedVoteCount(address owner) internal view returns (uint256) {
        // return receivedVoteCount(owner);
    }

    function getTotalVoteCount(address owner) internal view returns (uint256) {
        // return totalVoteCount(owner);
    }

}
