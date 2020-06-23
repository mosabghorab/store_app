import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeapp/src/models/local_models/address.dart';
import 'package:storeapp/src/utils/constants.dart';

class AddressController {
  static AddressController _instance;
  CollectionReference _addressesReference;

  //||... private constructor ...||
  AddressController._() {
    _addressesReference =
        Firestore.instance.collection(Constants.FIREBASE_COLLECTIONS_ADDRESSES);
  }

  // ||.. singleton pattern ..||
  static AddressController get instance {
    if (_instance != null) return _instance;
    return _instance = AddressController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  // Create new address for a user.
  Future<void> createAddress(Address address) async {
    return await _addressesReference.document().setData(address.toJson());
  }

  // get all addresses for a user.
  Stream<QuerySnapshot> getAddressesForUser(String clientId) {
    return _addressesReference
        .where(Constants.FIREBASE_ADDRESSES_FIELD_CLIENT_ID,
            isEqualTo: clientId)
        .snapshots();
  }

  // get an address.
  Future<Address> getAddress(String id) async {
    DocumentSnapshot documentSnapshot =
        await _addressesReference.document(id).get();
    return Address.fromJson(documentSnapshot.data)
      ..id = documentSnapshot.documentID;
  }
}
