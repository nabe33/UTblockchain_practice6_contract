// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/VariableExample.sol";

contract VariableExampleTest is Test {
    VariableExample public variableExample;

    function setUp() public {
        // 初期値を100でVariableExampleコントラクトをデプロイ
        variableExample = new VariableExample(100);
    }

    function testMemberVariable() public {
        // 初期値が正しいか確認
        uint256 initialValue = variableExample.getMemberVariable();
        assertEq(
            initialValue,
            100,
            "Initial value of memberVariable is incorrect"
        );
        console.log(
            "Initial value of memberVariable is correct:",
            initialValue
        );

        // メンバ変数を更新
        variableExample.updateMemberVariable(200);
        uint256 updatedValue = variableExample.getMemberVariable();
        assertEq(
            updatedValue,
            200,
            "Updated value of memberVariable is incorrect"
        );
        console.log(
            "Updated value of memberVariable is correct:",
            updatedValue
        );
    }

    function testLocalVariable() public view {
        // ローカル変数を使用した計算結果を確認
        uint256 input = 10;
        uint256 result = variableExample.calculateWithLocalVariable(input);
        assertEq(result, 30, "Local variable calculation is incorrect");
        console.log("Local variable calculation is correct:", result);
    }

    function testDifferenceBetweenMemberAndLocal() public {
        // メンバ変数とローカル変数の違いを確認
        uint256 input = 50;

        // メンバ変数の現在の値を取得
        uint256 beforeMemberValue = variableExample.getMemberVariable();

        // demonstrateDifferenceを呼び出し
        uint256 localResult = variableExample.demonstrateDifference(input);

        // ローカル変数の結果を確認
        assertEq(localResult, input + 10, "Local variable result is incorrect");
        console.log("Local variable result is correct:", localResult);

        // メンバ変数が更新されていることを確認
        uint256 afterMemberValue = variableExample.getMemberVariable();
        assertEq(
            afterMemberValue,
            beforeMemberValue + input,
            "Member variable update is incorrect"
        );
        console.log(
            "Member variable update is correct. Before:",
            beforeMemberValue,
            "After:",
            afterMemberValue
        );
    }
}
