import 'package:flutter/material.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/app_shared.dart';

class ImageSourceDialog extends StatelessWidget {
  Function _onCameraTap;
  Function _onGalleryTap;

  ImageSourceDialog({Function onCameraTap, Function onGalleryTap}) {
    this._onCameraTap = onCameraTap;
    this._onGalleryTap = onGalleryTap;
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Container(
      height: AppShared.screenUtil.setHeight(600),
      alignment: AlignmentDirectional.centerStart,
      padding: AppStyles.defaultPadding3,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              'Choose From',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: _onCameraTap,
            title: Text('Camera'),
          ),
          ListTile(
            onTap: _onGalleryTap,
            title: Text('Gallery'),
          ),
        ],
      ),
    );
  }
}
