// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ConditionExample.sol";

contract ConditionExampleTest is Test {
    ConditionExample public conditionExample;

    function setUp() public {
        conditionExample = new ConditionExample();
    }

    function testCheckValue_LessThan10() public {
        conditionExample.setValue(5);
        string memory result = conditionExample.checkValue();
        assertEq(result, "Value is less than 10", unicode"値が10未満のときのメッセージが正しくありません");
        console.log(unicode"値が10未満のとき: ", result);
    }

    function testCheckValue_Exactly10() public {
        conditionExample.setValue(10);
        string memory result = conditionExample.checkValue();
        assertEq(result, unicode"Value is exactly 10", unicode"値が10のときのメッセージが正しくありません");
        console.log(unicode"値が10のとき: ", result);
    }

    function testCheckValue_GreaterThan10() public {
        conditionExample.setValue(15);
        string memory result = conditionExample.checkValue();
        assertEq(result, "Value is greater than 10", unicode"値が10より大きいときのメッセージが正しくありません");
        console.log(unicode"値が10より大きいとき: ", result);
    }
}
