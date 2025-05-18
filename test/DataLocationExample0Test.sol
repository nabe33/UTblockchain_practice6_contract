// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/DataLocationExample0.sol";

contract DataLocationExample0Test is Test {
    DataLocationExample0 dataLocationExample0;

    // テストの前準備として、コントラクトをデプロイ
    function setUp() public {
        dataLocationExample0 = new DataLocationExample0(); // 初期値でデプロイ
        emit log_string(
            "Contract deployed with initial storedArray = [1, 2, 3]"
        );
    }

    // Storageの挙動を確認するテスト
    function testModifyWithStorage() public {
        dataLocationExample0.modifyWithStorage();

        uint[] memory expected = new uint[](3); // 配列を宣言
        expected[0] = 100;
        expected[1] = 2;
        expected[2] = 3;

        uint[] memory actual = dataLocationExample0.getStoredArray();

        bool success = true;
        for (uint i = 0; i < expected.length; i++) {
            if (actual[i] != expected[i]) {
                success = false;
                break;
            }
        }

        if (!success) {
            emit log_string(
                "Error: storedArray was not modified correctly by modifyWithStorage"
            );
            for (uint i = 0; i < actual.length; i++) {
                assertEq(
                    actual[i],
                    expected[i],
                    "Mismatch in storedArray at index "
                );
            }
        } else {
            emit log_string(
                "Success: storedArray correctly modified by modifyWithStorage"
            );
        }
    }

    // Memoryの挙動を確認するテスト
    function testModifyWithMemory() public {
        uint[] memory modifiedArray = dataLocationExample0.modifyWithMemory();

        // Memoryのコピー内のみ変更が反映され、storedArrayには影響がない
        uint[] memory expectedModified = new uint[](3); // 配列を宣言
        expectedModified[0] = 200;
        expectedModified[1] = 2;
        expectedModified[2] = 3;

        uint[] memory expectedOriginal = new uint[](3); // 配列を宣言
        expectedOriginal[0] = 1;
        expectedOriginal[1] = 2;
        expectedOriginal[2] = 3;

        // Memoryの変更が正しいかチェック
        for (uint i = 0; i < modifiedArray.length; i++) {
            assertEq(
                modifiedArray[i],
                expectedModified[i],
                "Memory array was not modified correctly"
            );
        }
        emit log_string(
            "Success: Memory array was modified correctly in modifyWithMemory"
        );

        // Storageが変わっていないかチェック
        uint[] memory actualStoredArray = dataLocationExample0.getStoredArray();
        for (uint i = 0; i < actualStoredArray.length; i++) {
            assertEq(
                actualStoredArray[i],
                expectedOriginal[i],
                "Storage array was unintentionally modified"
            );
        }
        emit log_string(
            "Success: Storage array was not modified by modifyWithMemory"
        );
    }

    // Calldataの挙動を確認するテスト
    function testModifyWithCalldata() public {
        uint[] memory inputArray = new uint[](3); // 配列を宣言
        inputArray[0] = 300;
        inputArray[1] = 400;
        inputArray[2] = 500;

        // Calldataを読み取るが変更はできない
        uint result = dataLocationExample0.modifyWithCalldata(inputArray);
        assertEq(result, inputArray[0], "Calldata was not read correctly");

        emit log_string(
            "Success: Calldata array was read correctly in modifyWithCalldata"
        );
    }
}
