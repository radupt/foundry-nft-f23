// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol"; // forge install OpenZeppelin/openzeppelin-contracts --no-commit

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();

        //assert(expectedName == actualName);
        // this can't be done because a string is an array of bytes, and we can't compare array to an array, only primitive types, we should compare the hashes of these 2 array
        assert(keccak256(bytes(expectedName)) == keccak256(bytes(actualName)));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(USER) == 1); // the quantity of nfts
        // make sure that the token URI is the PUG
        assert(keccak256(bytes(PUG)) == keccak256(bytes(basicNft.tokenURI(0))));
    }
}
