// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TestMerkleProof {
    bytes32[] public hashes;
    bytes32 root;
    bool score = false;

    constructor() {
         
        root = 0xe2de7e936cd2e3b398a5b5b89726a8d72148b93050d271cf91ffec3cc5598577;

        string[7] memory transactions = [
            "zkpenguin",
            "zkpancake",
            "zkpolice",
            "zkpig",
            "zkplayground",
            "zkpigeon",
            "zkpoison"
        ];

        for (uint i = 0; i < transactions.length; i++) {
            hashes.push(keccak256(abi.encodePacked(transactions[i])));
        }

        
    }

    function merkleProof(bytes32[] memory proof) public {
  
        bytes32 leaf = keccak256(abi.encodePacked("zkplayground"));
        require(verify(proof, root, leaf), "Your proof is incorrect!");
        score = true;
  
    }

    function verify(
        bytes32[] memory proof,
        bytes32 _root,
        bytes32 leaf
    ) internal pure returns (bool) {
        return processProof(proof, leaf) == _root;
    }


    function processProof(bytes32[] memory proof, bytes32 leaf)
        internal
        pure
        returns (bytes32)
    {
        bytes32 computedHash = leaf;
        for (uint256 i = 0; i < proof.length; i++) {
            computedHash = _hashPair(computedHash, proof[i]);
        }
        return computedHash;
    }

    function _hashPair(bytes32 a, bytes32 b) private pure returns (bytes32) {
        return a < b ? _efficientHash(a, b) : _efficientHash(b, a);
    }

    function _efficientHash(bytes32 a, bytes32 b)
        private
        pure
        returns (bytes32 value)
    {
        assembly {
            mstore(0x00, a)
            mstore(0x20, b)
            value := keccak256(0x00, 0x40)
        }
    }

}