import 'package:flutter/material.dart';
import 'package:storeapp/src/utils/app_shared.dart';

// ignore: must_be_immutable
class ParentComponent extends StatelessWidget {
  Widget child;
  String _currentLang = AppShared.sharedPreferencesController.getAppLang();

  ParentComponent({this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Directionality(
        textDirection:
            _currentLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: child,
      ),
    );
  }
}
