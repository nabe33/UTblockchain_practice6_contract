// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/AssetManager.sol";

contract AssetManagerTest is Test {
    AssetManager public assetManager;

    function setUp() public {
        assetManager = new AssetManager();
    }

    function testRegisterSingleAddress() public {
        address addr = address(0x123);
        assetManager.registAddress(addr);

        uint256 count = assetManager.getRegisteredCount();
        assertEq(count, 1, unicode"登録アドレス数が1であるべきです");
        console.log(unicode"登録アドレス数が正しい: ", count);

        address stored = assetManager.getRegisteredAddress(0);
        assertEq(stored, addr, unicode"登録アドレスが一致しません");
        console.log(unicode"登録アドレスが正しく保存されています: ", stored);
    }

    function testRegisterMultipleAddresses() public {
        address addr1 = address(0x111);
        address addr2 = address(0x222);
        address addr3 = address(0x333);

        assetManager.registAddress(addr1);
        assetManager.registAddress(addr2);
        assetManager.registAddress(addr3);

        uint256 count = assetManager.getRegisteredCount();
        assertEq(count, 3, unicode"登録アドレス数が3であるべきです");
        console.log(unicode"複数アドレス登録時の登録数が正しい: ", count);

        assertEq(assetManager.getRegisteredAddress(0), addr1, unicode"1番目のアドレスが一致しません");
        assertEq(assetManager.getRegisteredAddress(1), addr2, unicode"2番目のアドレスが一致しません");
        assertEq(assetManager.getRegisteredAddress(2), addr3, unicode"3番目のアドレスが一致しません");
        console.log(
            unicode"複数アドレスが順番通り正しく保存されています: ",
            assetManager.getRegisteredAddress(0),
            assetManager.getRegisteredAddress(1),
            assetManager.getRegisteredAddress(2)
        );
    }

    // Foundryのテストは各テスト関数ごとに新しいコントラクトインスタンス（setUp()で初期化）を使う
    function testGetRegisteredAddress_OutOfBounds() public {
        assetManager.registAddress(address(0x1));
        // 登録数は1なので、インデックス1は範囲外
        vm.expectRevert("Index out of bounds"); // この後に呼ばれる関数がrevert(例外)を発生させることを期待するための記述．そのエラーメッセージも検証．
        assetManager.getRegisteredAddress(1); // インデックス1は範囲外なのでrevertが発生する．revertが発生しない場合、テストは失敗する
        console.log(unicode"範囲外アクセス時に正しくrevertされました"); // revertが発生した場合、この行は実行されないため、テストは失敗しない
    }
}

// vm.expectrevert: Foundryのテストで「この後の操作でrevert（例外）が発生することを期待する」ことを明示するための機能
