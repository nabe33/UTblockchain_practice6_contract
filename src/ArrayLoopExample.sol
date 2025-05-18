// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ArrayLoopExample {
    uint[] public numbers;
    uint public sum;

    // 数値を配列に追加する関数
    function addNumber(uint _number) public {
        numbers.push(_number);
    }

    // 配列内の数値の合計を計算する関数
    function calculateSum() public returns (uint) {
        sum = 0; // 初期化
        for (uint i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }
}
