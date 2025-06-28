# UTblockchain_practice_contract
東大ブロックチェーン公開講座の「スマコン開発学習」演習 6回目（スライド70）

AssetManager.solが主体

## .env 設定

```
PRIVATE_KEY=
CONTRACT_ADDRESS= 
```

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## 動作手順

### 1． Format（省略可能）

```shell
$ forge fmt --check
$ forge fmt
```

### 2． Build

```shell
$ forge build
```

### 3． Test

```shell
$ forge test --match-path test/AssetManagerTest.sol -vv
```

### 4． Anvil起動

```shell
$ anvil
```

### 5． Deploy

```shell
$ forge script script/Deployment.s.sol --rpc-url http://127.0.0.1:8545 --broadcast
```

### Cast：必要ならば
Foundryに含まれるEVMとスマートコントラクトを操作するためのCLIツール

```shell
$ cast <subcommand>
```

### 参考：Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
