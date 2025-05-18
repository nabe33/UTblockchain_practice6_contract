// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/UserStorge.sol";

contract UserStorageTest is Test {
    UserStorage public userStorage;

    function setUp() public {
        userStorage = new UserStorage();
        emit log_string("UserStorage contract deployed.");
    }

    function testRegisterAndGetUser() public {
        // ユーザ登録
        string memory name = "Alice";
        userStorage.registerUser(name);

        // getUserで取得
        (string memory gotName, address gotAddr) = userStorage.getUser(address(this));
        assertEq(gotAddr, address(this), unicode"getUser: アドレスが一致しません");
        assertEq(gotName, name, unicode"getUser: 名前が一致しません");
        console.log(unicode"getUser: 正しくユーザ情報を取得できました:", gotName, gotAddr);

        // getMyUserで取得
        (string memory myName, address myAddr) = userStorage.getMyUser();
        assertEq(myAddr, address(this), unicode"getMyUser: アドレスが一致しません");
        assertEq(myName, name, unicode"getMyUser: 名前が一致しません");
        console.log(unicode"getMyUser: 正しく自身のユーザ情報を取得できました:", myName, myAddr);
    }

    function testGetUserNotRegistered() public view {
        // 未登録アドレスでgetUserを呼ぶ
        address notRegistered = address(0x1234);
        (string memory gotName, address gotAddr) = userStorage.getUser(notRegistered);
        assertEq(bytes(gotName).length, 0, unicode"未登録ユーザ名は空文字列であるべき");
        assertEq(gotAddr, address(0), unicode"未登録ユーザアドレスは0アドレスであるべき");
        console.log(unicode"未登録ユーザ取得時、空の情報が返ることを確認しました");
    }
}
