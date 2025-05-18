// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/DataLocationExample.sol";

contract DataLocationExampleTest is Test {
    DataLocationExample public example;

    function setUp() public {
        example = new DataLocationExample();
    }

    function testModifyStorage() public {
        // 初期状態でstorageArrayは空
        assertEq(example.storageArrayLength(), 0, "storageArray should be empty initially");

        // modifyStorageを呼び出すとstorageArrayに1つ追加される
        example.modifyStorage();
        uint256 len = example.storageArrayLength();
        assertEq(len, 1, "storageArray length should be 1 after modifyStorage");
        console.log("storageArray length after modifyStorage is correct:", len);

        // さらにもう一度呼び出すと2つになる
        example.modifyStorage();
        len = example.storageArrayLength();
        assertEq(len, 2, "storageArray length should be 2 after second modifyStorage");
        console.log("storageArray length after second modifyStorage is correct:", len);
    }

    function testProcessMemory() public view {
        uint256[] memory arr = new uint256[](3);
        arr[0] = 1;
        arr[1] = 2;
        arr[2] = 3;

        uint256 result = example.processMemory(arr);
        // arr[0]はmemory内で999に書き換えられるので、合計は999+2+3=1004
        assertEq(result, 1004, "processMemory should return 1004");
        console.log("processMemory returns correct sum:", result);

        // 呼び出し元のarrには影響しない（memoryなのでテストでは確認できないが、エラーが出なければOK）
    }

    function testProcessCalldata() public {
        uint256[] memory arr = new uint256[](3);
        arr[0] = 10;
        arr[1] = 20;
        arr[2] = 30;

        // calldataはexternal関数なので、callで呼び出す
        (bool success, bytes memory data) =
            address(example).call(abi.encodeWithSignature("processCalldata(uint256[])", arr));
        require(success, "processCalldata call failed");

        uint256 result = abi.decode(data, (uint256));
        assertEq(result, 60, "processCalldata should return 60");
        console.log("processCalldata returns correct sum:", result);

        // 書き換え不可のため、input[0]=123のような操作はコンパイルエラーになることも確認済み
    }

    function testStorageArrayLength() public {
        // 初期状態で長さは0
        uint256 len = example.storageArrayLength();
        assertEq(len, 0, "storageArrayLength should be 0 initially");
        console.log("storageArrayLength is correct initially:", len);

        // modifyStorageで1つ追加
        example.modifyStorage();
        len = example.storageArrayLength();
        assertEq(len, 1, "storageArrayLength should be 1 after one modifyStorage");
        console.log("storageArrayLength is correct after one modifyStorage:", len);

        // さらに追加
        example.modifyStorage();
        len = example.storageArrayLength();
        assertEq(len, 2, "storageArrayLength should be 2 after two modifyStorage");
        console.log("storageArrayLength is correct after two modifyStorage:", len);
    }
}
