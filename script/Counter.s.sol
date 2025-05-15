// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        // 既にデプロイ済みのCounterコントラクトのアドレスを指定
        address counterAddress = 0x5FbDB2315678afecb367f032d93F642f64180aa3;

        // コントラクトインスタンスを取得
        Counter counter = Counter(counterAddress);

        // setNumber 関数を呼び出して値を設定
        counter.setNumber(5);

        // increment 関数を呼び出して値をインクリメント
        counter.increment();

        // 現在の number の値を取得
        uint256 currentNumber = counter.number();
        console.log("Current number:", currentNumber);
    }
}
