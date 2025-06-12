## halmos-stateful-erc20

Stateful Halmos tests for ERC20 tokens

### Tests

#### Foundry

```bash
$ forge test
[⠊] Compiling...
[⠃] Compiling 1 files with Solc 0.8.25
[⠊] Solc 0.8.25 finished in 851.89ms
Compiler run successful!

Ran 1 test for test/ERC20.t.sol:ERC20Test
[FAIL: assertion failed: 0 != 300000000000000000000]
        [Sequence] (original: 7, shrunk: 2)
                sender=0x0000000000000000000000000000000000020000 addr=[test/Handler.sol:Handler]0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9 calldata=transfer(address,uint256) args=[0x0000000000000000000000000000000000010000, 2322574914650356325 [2.322e18]]
                sender=0x0000000000000000000000000000000000010000 addr=[test/Handler.sol:Handler]0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9 calldata=transfer(address,uint256) args=[0x0000000000000000000000000000000000010000, 2322574914650356325 [2.322e18]]
 invariant_sum_balanceOf_eq_totalSupply() (runs: 0, calls: 0, reverts: 6)
Suite result: FAILED. 0 passed; 1 failed; 0 skipped; finished in 73.16ms (68.51ms CPU time)

Ran 1 test suite in 200.16ms (73.16ms CPU time): 0 tests passed, 1 failed, 0 skipped (1 total tests)

Failing tests:
Encountered 1 failing test in test/ERC20.t.sol:ERC20Test
[FAIL: assertion failed: 0 != 300000000000000000000]
        [Sequence] (original: 7, shrunk: 2)
                sender=0x0000000000000000000000000000000000020000 addr=[test/Handler.sol:Handler]0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9 calldata=transfer(address,uint256) args=[0x0000000000000000000000000000000000010000, 2322574914650356325 [2.322e18]]
                sender=0x0000000000000000000000000000000000010000 addr=[test/Handler.sol:Handler]0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9 calldata=transfer(address,uint256) args=[0x0000000000000000000000000000000000010000, 2322574914650356325 [2.322e18]]
 invariant_sum_balanceOf_eq_totalSupply() (runs: 0, calls: 0, reverts: 6)

Encountered a total of 1 failing tests, 0 tests succeeded
```

#### Halmos

```bash
$ halmos --flamegraph --early-exit
Flamegraphs will be written to exec-flamegraph.svg and call-flamegraph.svg
[⠊] Compiling...
[⠘] Compiling 1 files with Solc 0.8.25
[⠃] Solc 0.8.25 finished in 652.15ms
Compiler run successful!

Running 1 tests for test/ERC20.t.sol:ERC20Test


╭─── Initial Invariant Target Functions ────╮
│ Handler.sol:Handler @ 0xaaaa0004          │
│ ├── approve(address,uint256)              │
│ ├── transfer(address,uint256)             │
│ └── transferFrom(address,address,uint256) │
│                                           │
│ Handler.sol:Handler @ 0xaaaa0005          │
│ ├── approve(address,uint256)              │
│ ├── transfer(address,uint256)             │
│ └── transferFrom(address,address,uint256) │
╰───────────────────────────────────────────╯


⠼ ERC20Test: depth: 1 | starting states: 1 | unique states: 1 | frontier states: 0 | completed paths: 0 Stack count is low (2). Did something go wrong?
⠇ invariant_sum_balanceOf_eq_totalSupply: [0:00:00] 114366 ops/s | completed paths: 0 | outstanding paths: 0
⠙ invariant_sum_balanceOf_eq_totalSupply: [0:00:00] 63428 ops/s | completed paths: 4 | outstanding paths: 1
⠇ invariant_sum_balanceOf_eq_totalSupply: [0:00:00] 60917 ops/s | completed paths: 4 | outstanding paths: 1
⠙ invariant_sum_balanceOf_eq_totalSupply: [0:00:00] 60138 ops/s | completed paths: 4 | outstanding paths: 1
⠦ invariant_sum_balanceOf_eq_totalSupply: [0:00:00] 82360 ops/s | completed paths: 1 | outstanding paths: 0
⠙ invariant_sum_balanceOf_eq_totalSupply: [0:00:00] 63989 ops/s | completed paths: 4 | outstanding paths: 1
Counterexample: 
    halmos_block_timestamp_depth1_e45c239 = 0x8000000000000000
    halmos_block_timestamp_depth2_219d510 = 0x8000000000000000
    halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_51ab599_49 = 0x20000
    halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_c76537f_23 = 0x20000
    halmos_msg_value_0x00000000000000000000000000000000aaaa0005_0c7a9bc_24 = 0x00
    halmos_msg_value_0x00000000000000000000000000000000aaaa0005_36da890_50 = 0x00
    p_amount_uint256_6c07bf3_26 = 0x100000
    p_amount_uint256_ebfac3f_52 = 0x00
    p_to_address_a9637e1_25 = 0x10000
    p_to_address_ed60dec_51 = 0x10000
Sequence:
    CALL 0xaaaa0005::transfer(Concat(p_to_address_a9637e1_25, p_amount_uint256_6c07bf3_26)) (value: halmos_msg_value_0x00000000000000000000000000000000aaaa0005_0c7a9bc_24) (caller: 
halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_c76537f_23)
        SLOAD  @2 → 0x0000000000000000000000007109709ecfa91a80626ff3989d68f67f5b1dd12d
        SLOAD  @1 → 0x0000000000000000000000000000000000000000000000000000000000000005
        SLOAD  @1 → 0x0000000000000000000000000000000000000000000000000000000000000005
        SLOAD  @0xb10e2d527612073b26eecdfd717e6a320cf44b4afac2b0732d9fcbe2b7fa0cf6 → 0x0000000000000000000000000000000000000000000000000000000000010000
        STATICCALL hevm::assume(0x0000000000000000000000000000000000000000000000000000000000000001) [static] (caller: 0xaaaa0005)
        ↩ 0x
        SLOAD  @2 → 0x0000000000000000000000007109709ecfa91a80626ff3989d68f67f5b1dd12d
        CALL hevm::prank(Concat(0x000000000000000000000000, halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_c76537f_23)) (caller: 0xaaaa0005)
        ↩ 0x
        SLOAD  @0 → 0x00000000000000000000000000000000000000000000000000000000aaaa0003
        CALL 0xaaaa0003::transfer(Concat(0x000000000000000000000000, Extract(0x9f, 0x00, p_to_address_a9637e1_25), p_amount_uint256_6c07bf3_26)) (caller: 
halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_c76537f_23)
            SLOAD  @6 → 0x0000000000000000000000000000000000000000000000000000000000000003
            SSTORE @6 ← 0x0000000000000000000000000000000000000000000000000000000000000004
            SLOAD  @f_sha3_512(Concat(0x000000000000000000000000, halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_c76537f_23, 
0x0000000000000000000000000000000000000000000000000000000000000000)) → Select(storage_0x00000000000000000000000000000000aaaa0003_0_2_512_20aa739_25, 
Concat(Concat(0x000000000000000000000000, halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_c76537f_23), 0x0000000000000000000000000000000000000000000000000000000000000000))
            SSTORE @f_sha3_512(Concat(0x000000000000000000000000, halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_c76537f_23, 
0x0000000000000000000000000000000000000000000000000000000000000000)) ← +(Select(storage_0x00000000000000000000000000000000aaaa0003_0_2_512_20aa739_25, Concat(0x000000000000000000000000, 
halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_c76537f_23, 0x0000000000000000000000000000000000000000000000000000000000000000)), 
*(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff, p_amount_uint256_6c07bf3_26))
            SLOAD  @f_sha3_512(Concat(0x000000000000000000000000, Extract(0x9f, 0x00, p_to_address_a9637e1_25), 0x0000000000000000000000000000000000000000000000000000000000000000)) → 
Select(storage_0x00000000000000000000000000000000aaaa0003_0_2_512_6d32b2c_29, Concat(Concat(0x000000000000000000000000, Extract(0x9f, 0x00, p_to_address_a9637e1_25)), 
0x0000000000000000000000000000000000000000000000000000000000000000))
            SSTORE @f_sha3_512(Concat(0x000000000000000000000000, Extract(0x9f, 0x00, p_to_address_a9637e1_25), 0x0000000000000000000000000000000000000000000000000000000000000000)) ← 
+(Select(storage_0x00000000000000000000000000000000aaaa0003_0_2_512_6d32b2c_29, Concat(0x000000000000000000000000, Extract(0x9f, 0x00, p_to_address_a9637e1_25), 
0x0000000000000000000000000000000000000000000000000000000000000000)), p_amount_uint256_6c07bf3_26)
            LOG3(topic0=0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef, topic1=Concat(0x000000000000000000000000, 
halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_c76537f_23), topic2=Concat(0x000000000000000000000000, Extract(0x9f, 0x00, p_to_address_a9637e1_25)), 
data=p_amount_uint256_6c07bf3_26)
        ↩ RETURN 0x0000000000000000000000000000000000000000000000000000000000000001
    ↩ RETURN 0x0000000000000000000000000000000000000000000000000000000000000001
    CALL 0xaaaa0005::transfer(Concat(p_to_address_ed60dec_51, p_amount_uint256_ebfac3f_52)) (value: halmos_msg_value_0x00000000000000000000000000000000aaaa0005_36da890_50) (caller: 
halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_51ab599_49)
        SLOAD  @2 → 0x0000000000000000000000007109709ecfa91a80626ff3989d68f67f5b1dd12d
        SLOAD  @1 → 0x0000000000000000000000000000000000000000000000000000000000000005
        SLOAD  @1 → 0x0000000000000000000000000000000000000000000000000000000000000005
        SLOAD  @0xb10e2d527612073b26eecdfd717e6a320cf44b4afac2b0732d9fcbe2b7fa0cf6 → 0x0000000000000000000000000000000000000000000000000000000000010000
        STATICCALL hevm::assume(0x0000000000000000000000000000000000000000000000000000000000000001) [static] (caller: 0xaaaa0005)
        ↩ 0x
        SLOAD  @2 → 0x0000000000000000000000007109709ecfa91a80626ff3989d68f67f5b1dd12d
        CALL hevm::prank(Concat(0x000000000000000000000000, halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_51ab599_49)) (caller: 0xaaaa0005)
        ↩ 0x
        SLOAD  @0 → 0x00000000000000000000000000000000000000000000000000000000aaaa0003
        CALL 0xaaaa0003::transfer(Concat(0x000000000000000000000000, Extract(0x9f, 0x00, p_to_address_ed60dec_51), p_amount_uint256_ebfac3f_52)) (caller: 
halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_51ab599_49)
            SLOAD  @6 → 0x0000000000000000000000000000000000000000000000000000000000000004
            SSTORE @6 ← 0x0000000000000000000000000000000000000000000000000000000000000005
            SLOAD  @f_sha3_512(Concat(0x000000000000000000000000, halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_51ab599_49, 
0x0000000000000000000000000000000000000000000000000000000000000000)) → Select(storage_0x00000000000000000000000000000000aaaa0003_0_2_512_43dc125_30, 
Concat(Concat(0x000000000000000000000000, halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_51ab599_49), 0x0000000000000000000000000000000000000000000000000000000000000000))
            SSTORE @f_sha3_512(Concat(0x000000000000000000000000, halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_51ab599_49, 
0x0000000000000000000000000000000000000000000000000000000000000000)) ← +(Select(storage_0x00000000000000000000000000000000aaaa0003_0_2_512_43dc125_30, Concat(0x000000000000000000000000, 
halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_51ab599_49, 0x0000000000000000000000000000000000000000000000000000000000000000)), 
*(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff, p_amount_uint256_ebfac3f_52))
            SLOAD  @f_sha3_512(Concat(0x000000000000000000000000, Extract(0x9f, 0x00, p_to_address_ed60dec_51), 0x0000000000000000000000000000000000000000000000000000000000000000)) → 
Select(storage_0x00000000000000000000000000000000aaaa0003_0_2_512_ac5fe4f_31, Concat(Concat(0x000000000000000000000000, Extract(0x9f, 0x00, p_to_address_ed60dec_51)), 
0x0000000000000000000000000000000000000000000000000000000000000000))
            SSTORE @f_sha3_512(Concat(0x000000000000000000000000, Extract(0x9f, 0x00, p_to_address_ed60dec_51), 0x0000000000000000000000000000000000000000000000000000000000000000)) ← 
+(Select(storage_0x00000000000000000000000000000000aaaa0003_0_2_512_ac5fe4f_31, Concat(0x000000000000000000000000, Extract(0x9f, 0x00, p_to_address_ed60dec_51), 
0x0000000000000000000000000000000000000000000000000000000000000000)), p_amount_uint256_ebfac3f_52)
            LOG3(topic0=0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef, topic1=Concat(0x000000000000000000000000, 
halmos_msg_sender_0x00000000000000000000000000000000aaaa0005_51ab599_49), topic2=Concat(0x000000000000000000000000, Extract(0x9f, 0x00, p_to_address_ed60dec_51)), 
data=p_amount_uint256_ebfac3f_52)
        ↩ RETURN 0x0000000000000000000000000000000000000000000000000000000000000001
    ↩ RETURN 0x0000000000000000000000000000000000000000000000000000000000000001

[FAIL] invariant_sum_balanceOf_eq_totalSupply() (paths: 3671, time: 196.41s, bounds: [])
Symbolic test result: 0 passed; 1 failed; time: 196.71s
⠏ invariant_sum_balanceOf_eq_totalSupply: [0:00:00] 117187 ops/s | completed paths: 0 | outstanding paths: 0
```

### Disclaimer

This code is provided "as is" and has not undergone a formal security audit.

Use it at your own risk. The author(s) assume no liability for any damages or losses resulting from the use of this code. It is your responsibility to thoroughly review, test, and validate its security and functionality before deploying or relying on it in any environment.
