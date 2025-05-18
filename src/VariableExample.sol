// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract VariableExample {
    // メンバ変数（状態変数）：コントラクトのストレージに保存され、関数間で値を保持
    uint256 public memberVariable;

    // コンストラクタでメンバ変数を初期化
    constructor(uint256 initialValue) {
        memberVariable = initialValue;
    }

    // メンバ変数を更新する関数
    function updateMemberVariable(uint256 newValue) public {
        memberVariable = newValue; // メンバ変数を更新
    }

    // ローカル変数を使用して計算を行う関数
    function calculateWithLocalVariable(uint256 input) public pure returns (uint256) {
        uint256 localVariable = input * 3; // ローカル変数
        return localVariable; // ローカル変数を返す
    }

    // メンバ変数とローカル変数の違いを示す関数
    function demonstrateDifference(uint256 input) public returns (uint256) {
        uint256 localVariable = input + 10; // ローカル変数
        memberVariable += input; // メンバ変数を更新（現在の値に加算）
        return localVariable; // ローカル変数を返す
    }

    // メンバ変数の値を取得する関数
    function getMemberVariable() public view returns (uint256) {
        return memberVariable; // メンバ変数を返す
    }
}
