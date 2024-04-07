// SPDX-License-Identifier: MIT

pragma solidity 0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() public returns (MoodNft) {
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");
        // string memory happySvg = vm.readFile("./img/output.svg");
        // console.log("sadSvg: ", sadSvg);
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(svgToImgURI(sadSvg), svgToImgURI(happySvg));
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImgURI(string memory svg) public pure returns (string memory) {
        string memory baseUrl = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));

        return string(abi.encodePacked(baseUrl, svgBase64Encoded));
    }
}
