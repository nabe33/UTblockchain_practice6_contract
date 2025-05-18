// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/// @title UserStorage
/// @notice ユーザ情報（名前とアドレス）をstructとmappingで管理するサンプルコントラクト
contract UserStorage {
    /// @notice ユーザ情報を格納する構造体
    struct User {
        string name; // ユーザ名
        address userAddr; // ユーザのアドレス
    }

    /// @notice アドレスからユーザ情報を取得するためのマッピング
    mapping(address => User) private users;

    /// @notice 新しいユーザを登録するイベント
    event UserRegistered(address indexed userAddr, string name);

    /// @notice ユーザ情報を登録または更新する関数
    /// @param name ユーザ名
    function registerUser(string memory name) public {
        users[msg.sender] = User(name, msg.sender);
        emit UserRegistered(msg.sender, name);
    }

    /// @notice 指定したアドレスのユーザ情報を取得する関数
    /// @param userAddr ユーザのアドレス
    /// @return name ユーザ名
    /// @return addr ユーザのアドレス
    function getUser(
        address userAddr
    ) public view returns (string memory name, address addr) {
        User memory user = users[userAddr];
        return (user.name, user.userAddr);
    }

    /// @notice 呼び出し元自身のユーザ情報を取得する関数
    /// @return name ユーザ名
    /// @return addr ユーザのアドレス
    function getMyUser()
        public
        view
        returns (string memory name, address addr)
    {
        User memory user = users[msg.sender];
        return (user.name, user.userAddr);
    }
}
