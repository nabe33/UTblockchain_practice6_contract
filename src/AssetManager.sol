// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/// @title AssetManager
/// @notice 任意のアドレスを登録・保存できるコントラクト
contract AssetManager {
    // 登録されたアドレスを保存する配列
    address[] public registeredAddresses;
    // アドレスの重複登録を防ぐためのマッピング
    mapping(address => bool) public isRegistered;
    // 各アドレスの資産（円）を管理するマッピング
    mapping(address => uint256) public assets;
    // 各アドレスのハッシュ値を管理するマッピング
    mapping(address => bytes32) public hashValues;

    /// @notice 任意のアドレスを登録する関数（重複不可）
    /// @param addr 登録したいアドレス
    function registAddress(address addr) public {
        // trueならば次行以下を実行．false（登録済み）ならばrevert
        require(!isRegistered[addr], "Address already registered");
        registeredAddresses.push(addr);
        isRegistered[addr] = true;
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

    /// @notice 登録済みアドレスが資産とハッシュ値を登録する関数
    /// @param yen 加算したい資産額（円）
    /// @param hashValue フロントエンドから送られてきたハッシュ値（SHA256）
    function registerAssetWithHash(uint256 yen, bytes32 hashValue) public {
        require(isRegistered[msg.sender], "Sender is not a registered address");
        assets[msg.sender] += yen;
        hashValues[msg.sender] = hashValue;
    }

    /// @notice 指定アドレスの資産額とハッシュ値を取得する関数
    /// @param addr 資産とハッシュ値を確認したいアドレス
    /// @return asset 資産額（円）
    /// @return hashValue 登録されたハッシュ値
    function getAssetWithHash(address addr) public view returns (uint256 asset, bytes32 hashValue) {
        return (assets[addr], hashValues[addr]);
    }

    /// @notice 指定アドレスのハッシュ値のみを取得する関数
    /// @param addr ハッシュ値を確認したいアドレス
    /// @return hashValue 登録されたハッシュ値
    function getHashValue(address addr) public view returns (bytes32 hashValue) {
        return hashValues[addr];
    }
}
