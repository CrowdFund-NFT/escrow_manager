import Array    "mo:base/Array";
import Blob     "mo:base/Blob";
import Nat8     "mo:base/Nat8";
import Nat32    "mo:base/Nat32";

import Hex      "./Hex";
import Types    "./types";

module {

    type AccountId = Types.AccountId;
    type AccountIdText = Types.AccountIdText;
    type Subaccount = Types.Subaccount;
    type SubaccountBlob = Types.SubaccountBlob;

    // Account helpers 

    public func accountIdToHex (a : AccountId) : AccountIdText {
        Hex.encode(Blob.toArray(a));
    };

    public func hexToAccountId (h : AccountIdText) : AccountId {
        Blob.fromArray(Hex.decode(h));
    };    

    public func defaultSubaccount () : SubaccountBlob {
        Blob.fromArrayMut(Array.init(32, 0 : Nat8))
    };

    public func natToBytes (n : Nat) : [Nat8] {
        nat32ToBytes(Nat32.fromNat(n));
    };

    public func nat32ToBytes (n : Nat32) : [Nat8] {
        func byte(n: Nat32) : Nat8 {
            Nat8.fromNat(Nat32.toNat(n & 0xff))
        };
        [byte(n >> 24), byte(n >> 16), byte(n >> 8), byte(n)]
    };

    public func subToSubBlob (sub : Subaccount) : SubaccountBlob {
        Blob.fromArray(natToBytes(sub));
    }

}