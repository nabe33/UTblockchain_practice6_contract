// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/LoopExample.sol";

contract LoopExampleTest is Test {
    LoopExample public loopExample;

    function setUp() public {
        loopExample = new LoopExample();
    }

    function testSumInConstructor() public view {
        // コンストラクタでsumが正しく計算されているか
        uint expected = 55; // 1+2+...+10
        uint actual = loopExample.sum();
        assertEq(
            actual,
            expected,
            unicode"sumの値が正しくありません（コンストラクタ）"
        );
        console.log(
            unicode"コンストラクタでsumが正しく計算されています:",
            actual
        );
    }

    function testCalculateSumFunction() public view {
        // calculateSum関数が正しい値を返すか
        uint expected = 55;
        uint actual = loopExample.calculateSum();
        assertEq(
            actual,
            expected,
            unicode"calculateSumの戻り値が正しくありません"
        );
        console.log(unicode"calculateSum関数が正しい値を返しています:", actual);
    }
}
