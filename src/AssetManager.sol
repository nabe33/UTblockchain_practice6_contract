// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/// @title AssetManager
/// @notice 任意のアドレスを登録・保存できるコントラクト
contract AssetManager {
    // 登録されたアドレスを保存する配列
    address[] public registeredAddresses;

    /// @notice 任意のアドレスを登録する関数
    /// @param addr 登録したいアドレス
    function registAddress(address addr) public {
        registeredAddresses.push(addr);
    }

    /// @notice 登録済みアドレスの数を取得
    function getRegisteredCount() public view returns (uint256) {
        return registeredAddresses.length;
    }

    /// @notice インデックス指定で登録済みアドレスを取得
    function getRegisteredAddress(uint256 index) public view returns (address) {
        require(index < registeredAddresses.length, "Index out of bounds");
        return registeredAddresses[index];
    }
}
