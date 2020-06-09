import 'package:storeapp/src/controllers/local_controllers/database_controllers/category_controller.dart';
import 'package:storeapp/src/models/local_models/address.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';

class AddressController {
  static AddressController _instance;
  CategoryController _categoryController;

  //||... private constructor ...||
  AddressController._() {
    _categoryController = CategoryController.instance;
  }

  // ||.. singleton pattern ..||
  static AddressController get instance {
    if (_instance != null) return _instance;
    return _instance = AddressController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  //create new Address.
  Future<int> createAddress(Address address) async {
    return await AppShared.db
        .insert(Constants.APP_DATABASE_TABLE_ADDRESSES, address.toJson());
  }

  //get all Addresses.
  Future<List<Address>> getAllAddresses(int clientId) async {
    List<Map> addressesJson = await AppShared.db.rawQuery(
        'SELECT * FROM ${Constants.APP_DATABASE_TABLE_ADDRESSES} where clientId=?',
        [clientId]);
    return addressesJson
        .map<Address>((value) => Address.fromJson(value))
        .toList();
  }

  //get all Addresses.
  Future<Address> getAddress(int id) async {
    List<Map> addressesJson = await AppShared.db.rawQuery(
        'SELECT * FROM ${Constants.APP_DATABASE_TABLE_ADDRESSES} where id=?',
        [id]);
    return Address.fromJson(addressesJson[0]);
  }

  //delete Address.
  Future<int> deleteAddress(int id) async {
    return await AppShared.db.delete(
      Constants.APP_DATABASE_TABLE_ADDRESSES,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  //update Address.
  Future<int> updateAddress(int id, Address address) async {
    return await AppShared.db.update(
      Constants.APP_DATABASE_TABLE_ADDRESSES,
      address.toJson(),
      where: 'id=?',
      whereArgs: [id],
    );
  }
}
