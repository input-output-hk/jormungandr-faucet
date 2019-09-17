/* tslint:disable */
/**
* @param {any} input 
* @returns {string} 
*/
export function uint8array_to_hex(input: any): string;
export enum AddressDiscrimination {
  Production,
  Test,
}
/**
* Allow to differentiate between address in
* production and testing setting, so that
* one type of address is not used in another setting.
* Example
* ```javascript
* let discriminant = AddressDiscrimination.Test;
* let address = Address::single_from_public_key(public_key, discriminant);
* ```
*/
/**
* This is either an single account or a multisig account depending on the witness type
*/
export class Account {
  free(): void;
/**
* @param {Address} address 
* @returns {Account} 
*/
  static from_address(address: Address): Account;
/**
* @returns {Address} 
*/
  to_address(): Address;
/**
* @param {PublicKey} key 
* @returns {Account} 
*/
  static from_public_key(key: PublicKey): Account;
}
/**
* An address of any type, this can be one of
* * A utxo-based address without delegation (single)
* * A utxo-based address with delegation (group)
* * An address for an account
*/
export class Address {
  free(): void;
/**
* Construct Address from its bech32 representation
* Example
* ```javascript
* const address = Address.from_string(&#39;ca1q09u0nxmnfg7af8ycuygx57p5xgzmnmgtaeer9xun7hly6mlgt3pjyknplu&#39;);
* ```
* @param {string} s 
* @returns {Address} 
*/
  static from_string(s: string): Address;
/**
* Get Address bech32 (string) representation with a given prefix
* ```javascript
* let public_key = PublicKey.from_bech32(
*     &#39;ed25519_pk1kj8yvfrh5tg7n62kdcw3kw6zvtcafgckz4z9s6vc608pzt7exzys4s9gs8&#39;
* );
* let discriminant = AddressDiscrimination.Test;
* let address = Address.single_from_public_key(public_key, discriminant);
* address.to_string(&#39;ta&#39;)
* // ta1sj6gu33yw73dr60f2ehp6xemgf30r49rzc25gkrfnrfuuyf0mycgnj78ende550w5njvwzyr20q6rypdea597uu3jnwfltljddl59cseaq7yn9
* ```
* @param {string} prefix 
* @returns {string} 
*/
  to_string(prefix: string): string;
/**
* Construct a single non-account address from a public key
* ```javascript
* let public_key = PublicKey.from_bech32(
*     &#39;ed25519_pk1kj8yvfrh5tg7n62kdcw3kw6zvtcafgckz4z9s6vc608pzt7exzys4s9gs8&#39;
* );
* let address = Address.single_from_public_key(public_key, AddressDiscrimination.Test);
* ```
* @param {PublicKey} key 
* @param {number} discrimination 
* @returns {Address} 
*/
  static single_from_public_key(key: PublicKey, discrimination: number): Address;
/**
* Construct a non-account address from a pair of public keys, delegating founds from the first to the second
* @param {PublicKey} key 
* @param {PublicKey} delegation 
* @param {number} discrimination 
* @returns {Address} 
*/
  static delegation_from_public_key(key: PublicKey, delegation: PublicKey, discrimination: number): Address;
/**
* Construct address of account type from a public key
* @param {PublicKey} key 
* @param {number} discrimination 
* @returns {Address} 
*/
  static account_from_public_key(key: PublicKey, discrimination: number): Address;
}
/**
* Amount of the balance in the transaction.
*/
export class Balance {
  free(): void;
/**
* @returns {any} 
*/
  get_sign(): any;
/**
* Get value without taking into account if the balance is positive or negative
* @returns {Value} 
*/
  get_value(): Value;
}
/**
* `Block` is an element of the blockchain it contains multiple
* transaction and a reference to the parent block. Alongside
* with the position of that block in the chain.
*/
export class Block {
  free(): void;
/**
* Deserialize a block from a byte array
* @param {any} bytes 
* @returns {Block} 
*/
  static from_bytes(bytes: any): Block;
/**
* @returns {BlockId} 
*/
  id(): BlockId;
/**
* @returns {BlockId} 
*/
  parent_id(): BlockId;
/**
*This involves copying all the messages
* @returns {Fragments} 
*/
  fragments(): Fragments;
}
/**
*/
export class BlockId {
  free(): void;
/**
* @returns {Uint8Array} 
*/
  as_bytes(): Uint8Array;
}
/**
*/
export class Certificate {
  free(): void;
/**
* Create a stake delegation certificate from account (stake key) to pool_id
* @param {StakePoolId} pool_id 
* @param {PublicKey} account 
* @returns {Certificate} 
*/
  static stake_delegation(pool_id: StakePoolId, account: PublicKey): Certificate;
/**
* @param {StakePoolInfo} pool_info 
* @returns {Certificate} 
*/
  static stake_pool_registration(pool_info: StakePoolInfo): Certificate;
/**
* Add signature to certificate
* @param {PrivateKey} private_key 
*/
  sign(private_key: PrivateKey): void;
/**
* @returns {Uint8Array} 
*/
  as_bytes(): Uint8Array;
/**
* @returns {string} 
*/
  to_bech32(): string;
}
/**
* Algorithm used to compute transaction fees
* Currently the only implementation if the Linear one
*/
export class Fee {
  free(): void;
/**
* Linear algorithm, this is formed by: `coefficient * (#inputs + #outputs) + constant + certificate * #certificate
* @param {Value} constant 
* @param {Value} coefficient 
* @param {Value} certificate 
* @returns {Fee} 
*/
  static linear_fee(constant: Value, coefficient: Value, certificate: Value): Fee;
/**
* Compute the fee if possible (it can fail in case the values are out of range)
* @param {Transaction} tx 
* @returns {Value} 
*/
  calculate(tx: Transaction): Value | undefined;
}
/**
* All possible messages recordable in the Block content
*/
export class Fragment {
  free(): void;
/**
* @param {GeneratedTransaction} tx 
* @returns {Fragment} 
*/
  static from_generated_transaction(tx: GeneratedTransaction): Fragment;
/**
* Get a Transaction if the Fragment represents one
* @returns {GeneratedTransaction} 
*/
  get_transaction(): GeneratedTransaction;
/**
* @returns {Uint8Array} 
*/
  as_bytes(): Uint8Array;
/**
* @returns {boolean} 
*/
  is_initial(): boolean;
/**
* @returns {boolean} 
*/
  is_transaction(): boolean;
/**
* @returns {boolean} 
*/
  is_certificate(): boolean;
/**
* @returns {boolean} 
*/
  is_old_utxo_declaration(): boolean;
/**
* @returns {boolean} 
*/
  is_update_proposal(): boolean;
/**
* @returns {boolean} 
*/
  is_update_vote(): boolean;
}
/**
*/
export class FragmentId {
  free(): void;
/**
* @param {Uint8Array} bytes 
* @returns {FragmentId} 
*/
  static from_bytes(bytes: Uint8Array): FragmentId;
/**
* @returns {Uint8Array} 
*/
  as_bytes(): Uint8Array;
}
/**
*/
export class Fragments {
  free(): void;
/**
* @returns {number} 
*/
  size(): number;
/**
* @param {number} index 
* @returns {Fragment} 
*/
  get(index: number): Fragment;
}
/**
* Type for representing a Transaction with Witnesses (signatures)
*/
export class GeneratedTransaction {
  free(): void;
/**
* @returns {TransactionSignDataHash} 
*/
  id(): TransactionSignDataHash;
/**
* Get a copy of the inner Transaction, discarding the signatures
* @returns {Transaction} 
*/
  transaction(): Transaction;
}
/**
* Type for representing a generic Hash
*/
export class Hash {
  free(): void;
/**
* @param {Uint8Array} bytes 
* @returns {Hash} 
*/
  static from_bytes(bytes: Uint8Array): Hash;
/**
* @param {string} hex_string 
* @returns {Hash} 
*/
  static from_hex(hex_string: string): Hash;
/**
* @returns {Uint8Array} 
*/
  as_bytes(): Uint8Array;
}
/**
*/
export class Input {
  free(): void;
/**
* @param {UtxoPointer} utxo_pointer 
* @returns {Input} 
*/
  static from_utxo(utxo_pointer: UtxoPointer): Input;
/**
* @param {Account} account 
* @param {Value} v 
* @returns {Input} 
*/
  static from_account(account: Account, v: Value): Input;
/**
* Get the kind of Input, this can be either \"Account\" or \"Utxo\
* @returns {string} 
*/
  get_type(): string;
/**
* @returns {Value} 
*/
  value(): Value;
/**
* Get the inner UtxoPointer if the Input type is Utxo
* @returns {UtxoPointer} 
*/
  get_utxo_pointer(): UtxoPointer;
/**
* Get the source Account if the Input type is Account
* @returns {Account} 
*/
  get_account(): Account;
}
/**
*/
export class Inputs {
  free(): void;
/**
* @returns {number} 
*/
  size(): number;
/**
* @param {number} index 
* @returns {Input} 
*/
  get(index: number): Input;
}
/**
*/
export class KesPublicKey {
  free(): void;
/**
* @param {string} bech32_str 
* @returns {KesPublicKey} 
*/
  static from_bech32(bech32_str: string): KesPublicKey;
}
/**
* Type for representing a Transaction Output, composed of an Address and a Value
*/
export class Output {
  free(): void;
/**
* @returns {Address} 
*/
  address(): Address;
/**
* @returns {Value} 
*/
  value(): Value;
}
/**
* Helper to add change addresses when finalizing a transaction, there are currently two options
* * forget: use all the excess money as fee
* * one: send all the excess money to the given address
*/
export class OutputPolicy {
  free(): void;
/**
* don\'t do anything with the excess money in transaction
* @returns {OutputPolicy} 
*/
  static forget(): OutputPolicy;
/**
* use the given address as the only change address
* @param {Address} address 
* @returns {OutputPolicy} 
*/
  static one(address: Address): OutputPolicy;
}
/**
*/
export class Outputs {
  free(): void;
/**
* @returns {number} 
*/
  size(): number;
/**
* @param {number} index 
* @returns {Output} 
*/
  get(index: number): Output;
}
/**
* ED25519 signing key, either normal or extended
*/
export class PrivateKey {
  free(): void;
/**
* Get private key from its bech32 representation
* ```javascript
* PrivateKey.from_bech32(&#39;ed25519_sk1ahfetf02qwwg4dkq7mgp4a25lx5vh9920cr5wnxmpzz9906qvm8qwvlts0&#39;);
* ```
* For an extended 25519 key
* ```javascript
* PrivateKey.from_bech32(&#39;ed25519e_sk1gqwl4szuwwh6d0yk3nsqcc6xxc3fpvjlevgwvt60df59v8zd8f8prazt8ln3lmz096ux3xvhhvm3ca9wj2yctdh3pnw0szrma07rt5gl748fp&#39;);
* ```
* @param {string} bech32_str 
* @returns {PrivateKey} 
*/
  static from_bech32(bech32_str: string): PrivateKey;
/**
* @returns {PublicKey} 
*/
  to_public(): PublicKey;
/**
* @returns {PrivateKey} 
*/
  static generate_ed25519(): PrivateKey;
/**
* @returns {PrivateKey} 
*/
  static generate_ed25519extended(): PrivateKey;
/**
* @returns {string} 
*/
  to_bech32(): string;
}
/**
* ED25519 key used as public key
*/
export class PublicKey {
  free(): void;
/**
* Get private key from its bech32 representation
* Example:
* ```javascript
* const pkey = PublicKey.from_bech32(&#39;ed25519_pk1dgaagyh470y66p899txcl3r0jaeaxu6yd7z2dxyk55qcycdml8gszkxze2&#39;);
* ```
* @param {string} bech32_str 
* @returns {PublicKey} 
*/
  static from_bech32(bech32_str: string): PublicKey;
/**
* @returns {Uint8Array} 
*/
  as_bytes(): Uint8Array;
}
/**
*/
export class PublicKeys {
  free(): void;
/**
* @returns {PublicKeys} 
*/
  constructor();
/**
* @returns {number} 
*/
  size(): number;
/**
* @param {number} index 
* @returns {PublicKey} 
*/
  get(index: number): PublicKey;
/**
* @param {PublicKey} key 
*/
  add(key: PublicKey): void;
}
/**
*/
export class SpendingCounter {
  free(): void;
/**
* @returns {SpendingCounter} 
*/
  static zero(): SpendingCounter;
/**
* @param {number} counter 
* @returns {SpendingCounter} 
*/
  static from_u32(counter: number): SpendingCounter;
}
/**
*/
export class StakePoolId {
  free(): void;
/**
* @param {string} hex_string 
* @returns {StakePoolId} 
*/
  static from_hex(hex_string: string): StakePoolId;
/**
* @returns {string} 
*/
  to_string(): string;
}
/**
*/
export class StakePoolInfo {
  free(): void;
/**
* @param {U128} serial 
* @param {PublicKeys} owners 
* @param {KesPublicKey} kes_public_key 
* @param {VrfPublicKey} vrf_public_key 
* @returns {StakePoolInfo} 
*/
  constructor(serial: U128, owners: PublicKeys, kes_public_key: KesPublicKey, vrf_public_key: VrfPublicKey);
/**
* @returns {StakePoolId} 
*/
  id(): StakePoolId;
}
/**
* Type representing a unsigned transaction
*/
export class Transaction {
  free(): void;
/**
* Get the transaction id, needed to compute its signature
* @returns {TransactionSignDataHash} 
*/
  id(): TransactionSignDataHash;
/**
* Get collection of the inputs in the transaction (this allocates new copies of all the values)
* @returns {Inputs} 
*/
  inputs(): Inputs;
/**
* Get collection of the outputs in the transaction (this allocates new copies of all the values)
* @returns {Outputs} 
*/
  outputs(): Outputs;
}
/**
* Builder pattern implementation for making a Transaction
*
* Example
*
* ```javascript
* const txbuilder = new TransactionBuilder();
*
* const account = Account.from_address(Address.from_string(
*   &#39;ca1qh9u0nxmnfg7af8ycuygx57p5xgzmnmgtaeer9xun7hly6mlgt3pj2xk344&#39;
* ));
*
* const input = Input.from_account(account, Value.from_str(\'1000\'));
*
* txbuilder.add_input(input);
*
* txbuilder.add_output(
*   Address.from_string(
*     &#39;ca1q5nr5pvt9e5p009strshxndrsx5etcentslp2rwj6csm8sfk24a2w3swacn&#39;
*   ),
*   Value.from_str(\'500\')
* );
*
* const feeAlgorithm = Fee.linear_fee(
*   Value.from_str(\'20\'),
*   Value.from_str(\'5\'),
*   Value.from_str(\'0\')
* );
*
* const finalizedTx = txbuilder.finalize(
*   feeAlgorithm,
*   OutputPolicy.one(accountInputAddress)
* );
* ```
*/
export class TransactionBuilder {
  free(): void;
/**
* @returns {TransactionBuilder} 
*/
  constructor();
/**
* Add certificate to the transaction if there isn\'t one already
* Example
* ```javascript
* const certificate = Certificate.stake_delegation(
*     StakePoolId.from_hex(poolId),
*     PublicKey.from_bech32(stakeKey)
* );
*
* certificate.sign(PrivateKey.from_bech32(privateKey));
*
* const txbuilder = new TransactionBuilder();
* txbuilder.set_certificate(certificate);
* ```
* @param {Certificate} certificate 
*/
  set_certificate(certificate: Certificate): void;
/**
* Add input to the transaction
* @param {Input} input 
*/
  add_input(input: Input): void;
/**
* Add output to the transaction
* @param {Address} address 
* @param {Value} value 
*/
  add_output(address: Address, value: Value): void;
/**
* Estimate fee with the currently added inputs, outputs and certificate based on the given algorithm
* @param {Fee} fee 
* @returns {Value} 
*/
  estimate_fee(fee: Fee): Value;
/**
* @param {Fee} fee 
* @returns {Balance} 
*/
  get_balance(fee: Fee): Balance;
/**
* @returns {Balance} 
*/
  get_balance_without_fee(): Balance;
/**
* Get the Transaction with the current inputs and outputs without computing the fees nor adding a change address
* @returns {Transaction} 
*/
  unchecked_finalize(): Transaction;
/**
* Finalize the transaction by adding the change Address output
* leaving enough for paying the minimum fee computed by the given algorithm
* see the unchecked_finalize for the non-assisted version
*
* Example
* 
* ```javascript
* const feeAlgorithm = Fee.linear_fee(
*     Value.from_str(\'20\'), Value.from_str(\'5\'), Value.from_str(\'10\')
* );
*
* const finalizedTx = txbuilder.finalize(
*   feeAlgorithm,
*   OutputPolicy.one(changeAddress)
* );
* ```
* @param {Fee} fee 
* @param {OutputPolicy} output_policy 
* @returns {Transaction} 
*/
  finalize(fee: Fee, output_policy: OutputPolicy): Transaction;
/**
* Get the current Transaction id, this will change when adding input, outputs and certificates
* @returns {TransactionSignDataHash} 
*/
  get_txid(): TransactionSignDataHash;
}
/**
* Builder pattern implementation for signing a Transaction (adding witnesses)
* Example (for an account as input)
*
* ```javascript
* //finalizedTx could be the result of the finalize method on a TransactionBuilder object
* const finalizer = new TransactionFinalizer(finalizedTx);
*
* const witness = Witness.for_account(
*   Hash.from_hex(genesisHashString),
*   finalizer.get_txid(),
*   inputAccountPrivateKey,
*   SpendingCounter.zero()
* );
*
* finalizer.set_witness(0, witness);
*
* const signedTx = finalizer.build();
* ```
*/
export class TransactionFinalizer {
  free(): void;
/**
* @param {Transaction} transaction 
* @returns {TransactionFinalizer} 
*/
  constructor(transaction: Transaction);
/**
* Set the witness for the corresponding index, the index corresponds to the order in which the inputs were added to the transaction
* @param {number} index 
* @param {Witness} witness 
*/
  set_witness(index: number, witness: Witness): void;
/**
* @returns {TransactionSignDataHash} 
*/
  get_txid(): TransactionSignDataHash;
/**
* @returns {GeneratedTransaction} 
*/
  build(): GeneratedTransaction;
}
/**
* Type for representing the hash of a Transaction, necessary for signing it
*/
export class TransactionSignDataHash {
  free(): void;
/**
* @param {Uint8Array} bytes 
* @returns {TransactionSignDataHash} 
*/
  static from_bytes(bytes: Uint8Array): TransactionSignDataHash;
/**
* @param {string} input 
* @returns {TransactionSignDataHash} 
*/
  static from_hex(input: string): TransactionSignDataHash;
/**
* @returns {Uint8Array} 
*/
  as_bytes(): Uint8Array;
}
/**
*/
export class U128 {
  free(): void;
/**
* @param {any} bytes 
* @returns {U128} 
*/
  static from_be_bytes(bytes: any): U128;
/**
* @param {any} bytes 
* @returns {U128} 
*/
  static from_le_bytes(bytes: any): U128;
/**
* @param {string} s 
* @returns {U128} 
*/
  static from_str(s: string): U128;
/**
* @returns {string} 
*/
  to_str(): string;
}
/**
* Unspent transaction pointer. This is composed of:
* * the transaction identifier where the unspent output is (a FragmentId)
* * the output index within the pointed transaction\'s outputs
* * the value we expect to read from this output, this setting is added in order to protect undesired withdrawal
* and to set the actual fee in the transaction.
*/
export class UtxoPointer {
  free(): void;
/**
* @param {FragmentId} fragment_id 
* @param {number} output_index 
* @param {Value} value 
* @returns {UtxoPointer} 
*/
  static new(fragment_id: FragmentId, output_index: number, value: Value): UtxoPointer;
}
/**
* Type used for representing certain amount of lovelaces.
* It wraps an unsigned 64 bits number.
* Strings are used for passing to and from javascript,
* as the native javascript Number type can\'t hold the entire u64 range
* and BigInt is not yet implemented in all the browsers
*/
export class Value {
  free(): void;
/**
* Parse the given string into a rust u64 numeric type.
* @param {string} s 
* @returns {Value} 
*/
  static from_str(s: string): Value;
/**
* Return the wrapped u64 formatted as a string.
* @returns {string} 
*/
  to_str(): string;
/**
* @param {Value} other 
* @returns {Value} 
*/
  checked_add(other: Value): Value;
/**
* @param {Value} other 
* @returns {Value} 
*/
  checked_sub(other: Value): Value;
}
/**
*/
export class VrfPublicKey {
  free(): void;
/**
* @param {string} bech32_str 
* @returns {VrfPublicKey} 
*/
  static from_bech32(bech32_str: string): VrfPublicKey;
}
/**
* Structure that proofs that certain user agrees with
* some data. This structure is used to sign `Transaction`
* and get `SignedTransaction` out.
*
* It\'s important that witness works with opaque structures
* and may not know the contents of the internal transaction.
*/
export class Witness {
  free(): void;
/**
* Generate Witness for an utxo-based transaction Input
* @param {Hash} genesis_hash 
* @param {TransactionSignDataHash} transaction_id 
* @param {PrivateKey} secret_key 
* @returns {Witness} 
*/
  static for_utxo(genesis_hash: Hash, transaction_id: TransactionSignDataHash, secret_key: PrivateKey): Witness;
/**
* Generate Witness for an account based transaction Input
* the account-spending-counter should be incremented on each transaction from this account
* @param {Hash} genesis_hash 
* @param {TransactionSignDataHash} transaction_id 
* @param {PrivateKey} secret_key 
* @param {SpendingCounter} account_spending_counter 
* @returns {Witness} 
*/
  static for_account(genesis_hash: Hash, transaction_id: TransactionSignDataHash, secret_key: PrivateKey, account_spending_counter: SpendingCounter): Witness;
/**
* Get string representation
* @returns {string} 
*/
  to_bech32(): string;
}
