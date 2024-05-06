/**
 * EXERCISE: Encrypted vote
 *
 * Imagine a situation where you want to ensure that the votes in an election are authentic and were, in fact, what the voters intended.
 * Also, you want to make sure the votes are not altered or revealed to anyone else.
 *
 * In this voting process, there are three parties. The voters, the election official and the candidates.
 * - Voters will vote for a candidate
 * - The electoral official will verify that the votes are authentic
 * - The candidates are those who will be chosen and voted for
 *
 * Voters will sign their vote with their private key and encrypt it with the election official's public key.
 * All votes are collected in an array and sent to the election officials.
 * The election official will decrypt each vote with his private key and verify that the vote is authentic.
 * The verification process means obtaining the public key address from the signature. If that public key matches
 * the voter's public key, then it's verify correctly and counted.
 *
 * Run the tests with the following command:
 * npx hardhat test test/voting.js
 */

var {
  sign,
  encryptWithPublicKey,
  hash,
  cipher,
  decryptWithPrivateKey,
  recoverPublicKey,
} = require("eth-crypto");

/**
 * @note This function takes each voter's vote and encrypts it with the official's public key
 *
 * @param {string} voterPrivateKey Each voter's private key
 * @param {string} candidate The candidate that the voters is voting for
 * @param {string} officialPublicKey The official's public key used to encrypt the message
 * @return {string} Returns a stringified version of the encrypted vote
 */
async function encryptVote(voterPrivateKey, candidate, officialPublicKey) {
  const signature = sign(voterPrivateKey, hash.keccak256(candidate));

  // Encrypt the signed vote with the official's public key
  var payload = JSON.stringify({
    message: candidate,
    signature,
  });
  var encryptedObject = await encryptWithPublicKey(officialPublicKey, payload);
  // Return the encrypted vote
  return cipher.stringify(encryptedObject);
}

/**
 * @note This function decrypts each vote with the official's private key and counts each valid vote
 *
 * @param {string[]} publicKeyVoters Array of public keys that belong to voters
 * @param {string[]} encryptedVotes An array of encrypted and stringified votes. Each vote is the output of 'encryptVote' function
 * @param {string} officialPrivateKey The official's private key used to decrypt each vote
 *
 * @return Returns table of votes where each candidate has a number of votes
 */
async function decryptVoteAndCount(
  publicKeyVoters,
  encryptedVotes,
  officialPrivateKey
) {
  const votesCount = {};
  for (let i = 0; i < encryptedVotes.length; i++) {
    var encrypted = cipher.parse(encryptedVotes[i]);
    var decrypted = await decryptWithPrivateKey(officialPrivateKey, encrypted);
    var decryptedObject = JSON.parse(decrypted);
    var publicKeyRecovered = recoverPublicKey(decryptedObject.signature, hash.keccak256(decryptedObject.message));

    if (publicKeyVoters.includes(publicKeyRecovered)) {

      if (!(publicKeyRecovered in votesCount)) {
        votesCount[publicKeyRecovered] = 1;

      } else {
        votesCount[publicKeyRecovered] += 1;
      }


    }

  }

  return votesCount;
}


module.exports = { encryptVote, decryptVoteAndCount };
