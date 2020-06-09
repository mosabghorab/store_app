import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/addresses_controller.dart';
import 'package:storeapp/src/models/local_models/address.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/client_screens_notifiers/home_screen_notifiers/pages_notifiers/adresses_page_notifiers.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/enums.dart';
import 'package:storeapp/src/utils/helpers.dart';
import 'package:storeapp/src/views/components/status_components/loading_component.dart';

class AddressesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddressesPageNotifiers>(
      create: (_) => AddressesPageNotifiers(),
      child: AddressesPageBody(),
    );
  }
}

class AddressesPageBody extends StatefulWidget {
  @override
  _AddressesPageBodyState createState() => _AddressesPageBodyState();
}

class _AddressesPageBodyState extends State<AddressesPageBody> {
  AddressesPageNotifiers _addressesPageNotifiers;
  AddressController _addressController;
  GlobalKey<FormState> _createAddressFormState;
  GlobalKey<ScaffoldState> _scaffoldState;

  String _addressName;
  String _country;
  String _city;
  int _streetNo;
  int _houseNo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createAddressFormState = GlobalKey();
    _addressController = AddressController.instance;
    _addressesPageNotifiers =
        Provider.of<AddressesPageNotifiers>(context, listen: false);
    _init();
  }

  void _init() async {
    _addressesPageNotifiers.addresses =
        await _addressController.getAllAddresses(AppShared.currentUser.id);
    _addressesPageNotifiers.isLoading = false;
  }

  void _createAddress() async {
    if (!_createAddressFormState.currentState.validate()) return;
    _createAddressFormState.currentState.save();
    Navigator.pop(context);
    _addressesPageNotifiers.isLoading = true;
    try {
      int result = await _addressController.createAddress(
        Address(
          name: _addressName,
          country: _country,
          city: _city,
          houseNo: _houseNo,
          streetNo: _streetNo,
          clientId: AppShared.currentUser.id,
        ),
      );
      _addressesPageNotifiers.addresses =
          await _addressController.getAllAddresses(AppShared.currentUser.id);
      await Future.delayed(Duration(seconds: 1));
      _addressesPageNotifiers.isLoading = false;
      if (result > 0)
        Helpers.showMessage(
            'Address created successfully', MessageType.MESSAGE_SUCCESS);
      else
        Helpers.showMessage('Operation failed', MessageType.MESSAGE_FAILED);
    } catch (error) {
      _addressesPageNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

  void _deleteAddress(index) async {
    Navigator.pop(context);
    _addressesPageNotifiers.isLoading = true;
    try {
      int result = await _addressController
          .deleteAddress(_addressesPageNotifiers.addresses[index].id);
      _addressesPageNotifiers.addresses =
          await _addressController.getAllAddresses(AppShared.currentUser.id);
      await Future.delayed(Duration(seconds: 1));
      _addressesPageNotifiers.isLoading = false;
      if (result > 0)
        Helpers.showMessage(
            'Address deleted successfully', MessageType.MESSAGE_SUCCESS);
      else
        Helpers.showMessage('Operation failed', MessageType.MESSAGE_FAILED);
    } catch (error) {
      _addressesPageNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AddressesPageNotifiers, bool>(
      selector: (_, value) => value.isLoading,
      builder: (_, isLoading, __) => Scaffold(
        key: _scaffoldState,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                child: Container(
                  height: 450,
                  padding: AppStyles.defaultPadding2,
                  child: Form(
                    key: _createAddressFormState,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text('Create new address')),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'address name'),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'address name is required';
                              else
                                return null;
                            },
                            onSaved: (value) {
                              _addressName = value;
                            },
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Country name'),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'country name is required';
                              else
                                return null;
                            },
                            onSaved: (value) {
                              _country = value;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'City name'),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'city name is required';
                              else
                                return null;
                            },
                            onSaved: (value) {
                              _city = value;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: 'Street number'),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'street number is required';
                              else
                                return null;
                            },
                            onSaved: (value) {
                              _streetNo = int.parse(value);
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: 'House number'),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'house number is required';
                              else
                                return null;
                            },
                            onSaved: (value) {
                              _houseNo = int.parse(value);
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              FlatButton(
                                onPressed: _createAddress,
                                child: Text('Create',
                                    style: TextStyle(color: Colors.blue)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: isLoading
              ? Container(
                  child: Center(
                    child: LoadingComponent(),
                  ),
                )
              : _addressesPageNotifiers.addresses.isEmpty
                  ? Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.location_disabled,
                              color: Colors.grey[700],
                              size: 100,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'No Addresses Found!!',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _addressesPageNotifiers.addresses.length,
                      itemBuilder: (_, index) => Card(
                        elevation: 4,
                        child: Container(
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  _addressesPageNotifiers.addresses[index].name,
                                  style: TextStyle(
                                    fontSize: 23,
                                  ),
                                ),
                                Text(
                                  "${_addressesPageNotifiers.addresses[index].country} , ${_addressesPageNotifiers.addresses[index].city} , ${_addressesPageNotifiers.addresses[index].streetNo} , ${_addressesPageNotifiers.addresses[index].houseNo}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            trailing: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('Delete address'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          _deleteAddress(index);
                                        },
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
