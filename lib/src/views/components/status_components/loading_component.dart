import 'package:flutter/material.dart';
import 'package:storeapp/src/utils/app_shared.dart';

class LoadingComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppShared.screenUtil.setHeight(400),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: AppShared.screenUtil.setHeight(20),
          ),
          Text(AppShared.appLang['Loading']),
        ],
      ),
    );
  }
}
