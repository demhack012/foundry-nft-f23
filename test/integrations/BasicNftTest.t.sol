// SPDX-License-Identifier: MIT

pragma solidity 0.8.22;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test {
    BasicNft basicNft;
    DeployBasicNft deployer;
    address public USER = makeAddr("user");
    string public constant SHIBA =
        "ipfs://bafybeigpcicalborgdgkjh6qnv64thf6uovhlfnsyxpgqbwtvh522r6ioi/?filename=shiba-inu-metadata.json";

    function setUp() external {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() external view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveABalance() external {
        vm.prank(USER);
        basicNft.mintNft(SHIBA);
        uint256 balance = basicNft.balanceOf(USER);
        assert(balance == 1);
        assert(keccak256(abi.encodePacked(SHIBA)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}
