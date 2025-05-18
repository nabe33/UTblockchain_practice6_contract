// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract LoopExample {
    uint public sum;

    // コンストラクタで1から10までの合計を計算
    constructor() {
        sum = calculateSum();
    }

    // 1から10までの合計を計算する関数
    function calculateSum() public pure returns (uint) {
        uint total = 0;
        for (uint i = 1; i <= 10; i++) {
            total += i;
        }
        return total;
    }
}
