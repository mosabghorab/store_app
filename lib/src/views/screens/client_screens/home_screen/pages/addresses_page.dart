import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/addresses_controller.dart';
import 'package:storeapp/src/models/local_models/address.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/client_screens_notifiers/home_screen_notifiers/pages_notifiers/adresses_page_notifiers.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';
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
  }

  void _createAddress() async {
    if (!_createAddressFormState.currentState.validate()) return;
    _createAddressFormState.currentState.save();
    Navigator.pop(context);
    _addressesPageNotifiers.isLoading = true;
    try {
      await _addressController.createAddress(
        Address(
          name: _addressName,
          country: _country,
          city: _city,
          houseNo: _houseNo,
          streetNo: _streetNo,
          clientId: AppShared.currentUser.uid,
        ),
      );
      _addressesPageNotifiers.isLoading = false;
      Helpers.showMessage(
          'Address created successfully', MessageType.MESSAGE_SUCCESS);
    } catch (error) {
      _addressesPageNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

  void _deleteAddress(String id) async {
    Navigator.pop(context);
    _addressesPageNotifiers.isLoading = true;
    try {
      await _addressController.deleteAddress(id);
      _addressesPageNotifiers.isLoading = false;
      Helpers.showMessage(
          'Address deleted successfully', MessageType.MESSAGE_SUCCESS);
    } catch (error) {
      _addressesPageNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: StreamBuilder<QuerySnapshot>(
          stream: _addressController
              .getAddressesForUserAsStream(AppShared.currentUser.uid),
          builder: (context, snapshot) {
            return Container(
              child: !snapshot.hasData
                  ? Container(
                      child: Center(
                        child: LoadingComponent(),
                      ),
                    )
                  : snapshot.hasData && snapshot.data.documents.isEmpty
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
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (_, index) => Card(
                            elevation: 4,
                            child: Container(
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data.documents[index].data[
                                          Constants
                                              .FIREBASE_ADDRESSES_FIELD_NAME],
                                      style: TextStyle(
                                        fontSize: 23,
                                      ),
                                    ),
                                    Text(
                                      "${snapshot.data.documents[index].data[Constants.FIREBASE_ADDRESSES_FIELD_COUNTRY]} , ${snapshot.data.documents[index].data[Constants.FIREBASE_ADDRESSES_FIELD_CITY]} , ${snapshot.data.documents[index].data[Constants.FIREBASE_ADDRESSES_FIELD_STREET_NO]} , ${snapshot.data.documents[index].data[Constants.FIREBASE_ADDRESSES_FIELD_HOUSE_NO]}",
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
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              _deleteAddress(snapshot.data
                                                  .documents[index].documentID);
                                            },
                                            child: Text(
                                              'Delete',
                                              style:
                                                  TextStyle(color: Colors.red),
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
            );
          }),
    );
  }
}
