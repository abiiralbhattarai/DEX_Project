// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/PanswapFactory.sol";
import "../src/PanswapPair.sol";
import "./mocks/MintableToken.sol";

contract PanswapFactoryTest is Test {
    PanswapFactory factory;

    MintableToken token0;
    MintableToken token1;
    MintableToken token2;
    MintableToken token3;

    function setUp() public {
        factory = new PanswapFactory();

        token0 = new MintableToken("Token A", "TKNA");
        token1 = new MintableToken("Token B", "TKNB");
        token2 = new MintableToken("Token C", "TKNC");
        token3 = new MintableToken("Token D", "TKND");
    }

    function encodeError(
        string memory error
    ) internal pure returns (bytes memory encoded) {
        encoded = abi.encodeWithSignature(error);
    }

    function testCreatePair() public {
        address pairAddress = factory.createPair(
            address(token1),
            address(token0)
        );

        PanswapPair pair = PanswapPair(pairAddress);

        assertEq(pair.token0(), address(token0));
        assertEq(pair.token1(), address(token1));
    }

    function testCreatePairZeroAddress() public {
        vm.expectRevert(encodeError("ZeroAddress()"));
        factory.createPair(address(0), address(token0));

        vm.expectRevert(encodeError("ZeroAddress()"));
        factory.createPair(address(token1), address(0));
    }

    function testCreatePairPairExists() public {
        factory.createPair(address(token1), address(token0));

        vm.expectRevert(encodeError("PairExists()"));
        factory.createPair(address(token1), address(token0));
    }

    function testCreatePairIdenticalTokens() public {
        vm.expectRevert(encodeError("IdenticalAddresses()"));
        factory.createPair(address(token0), address(token0));
    }
}
