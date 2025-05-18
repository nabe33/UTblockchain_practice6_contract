// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/// @title DataLocationExample
/// @notice データロケーション（storage, memory, calldata）の違いを示すサンプルコントラクト

contract DataLocationExample {
    // ----- storage: 永続的にブロックチェーン上に保存されるデータ -----
    // 関数の外で宣言しているので状態変数。自動的に storage に配置される
    uint256[] public storageArray;

    /// @notice storage を使った例
    /// @dev storageArray の参照を取得し、値を変更すると永続化される
    function modifyStorage() public {
        // storageArray の storage 参照を取得（storageを要略するとエラーになる）
        uint256[] storage localStorageRef = storageArray;
        // localStorageRef は storageArray と同じストレージ領域を指す
        localStorageRef.push(block.timestamp);
        // storageArray に block.timestamp が追加される
    }

    /// @notice memory を使った例
    /// @param input 一時的に操作したい配列データ
    /// @return sum 配列 input の合計値
    function processMemory(uint256[] memory input) public pure returns (uint256 sum) {
        // memory は関数の実行中のみ有効な一時的領域
        // memory 内であれば要素の変更が可能だが、元のデータには影響しない
        input[0] = 999; // memory 内であれば書き込み可能
        uint256 total = 0;
        for (uint256 i = 0; i < input.length; i++) {
            total += input[i];
        }
        return total;
    }

    /// @notice calldata を使った例
    /// @param input external 関数呼び出し時の引数データ
    /// @return total 配列 input の合計値
    function processCalldata(uint256[] calldata input) external pure returns (uint256 total) {
        // totalは暗黙的に0に初期化されている
        // calldata は読み取り専用の引数領域
        // input[0] = 123; // <-- この行はコンパイルエラーになる（書き込み不可）
        for (uint256 i = 0; i < input.length; i++) {
            total += input[i];
        }
        return total;
    }

    /// @notice storageArrayの長さを返す関数
    function storageArrayLength() public view returns (uint256) {
        return storageArray.length;
    }
}
