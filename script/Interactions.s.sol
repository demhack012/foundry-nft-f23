// SPDX-License-Identifier: MIT

pragma solidity 0.8.22;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public constant SHIBA =
        "https://ipfs.io/ipfs/QmYdhkV4tveeqdN8bJKa1wZgpHTXLjBtd3WKHnEykG4T5w?filename=shiba.json";

    string public constant PUG = "https://ipfs.io/ipfs/QmSEDJ7zbD2QVAchf8QCEbLTCtebK713veCiz1eLZCibhE?filename=pug.json";

    // string public constant BOMB =
    //     "https://ipfs.io/ipfs/QmVP1EecdFB46oSNaxe9gmH623Bw2PfauefK6fC3R97CXB?filename=bomb.json";

    function run() external {
        address latestDeployment = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(latestDeployment);
    }

    function mintNftOnContract(address basicNftAddress) public {
        vm.startBroadcast();
        BasicNft basicNft = BasicNft(basicNftAddress);
        basicNft.mintNft(SHIBA);
        basicNft.mintNft(PUG);
        // basicNft.mintNft(BOMB);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        address latestDeployment = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        mintMoodNftOnContract(latestDeployment);
    }

    function mintMoodNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft moodNft = MoodNft(moodNftAddress);
        moodNft.mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    function run() external {
        address latestDeployment = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        flipMoodNftOnContract(latestDeployment);
    }

    function flipMoodNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft moodNft = MoodNft(moodNftAddress);
        moodNft.flipMood(0);
        vm.stopBroadcast();
    }
}
