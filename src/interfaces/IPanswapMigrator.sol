// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.18;

interface IPanswapMigrator {
    function migrate(
        address token,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external;
}
