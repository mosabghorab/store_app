//||... Class for all helpers methods ...||
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/src/langs/ar_lang.dart';
import 'package:storeapp/src/langs/en_lang.dart';
import 'package:storeapp/src/utils/constants.dart';

import 'app_shared.dart';
import 'enums.dart';

class Helpers {
  // method for showing an message .
  static void showMessage(String message, MessageType messageType) {
    if (message == null) return;
    if (messageType == MessageType.MESSAGE_FAILED)
      BotToast.showNotification(
        trailing: (_) => Icon(
          Icons.arrow_forward_ios,
          color: Colors.red,
        ),
        title: (_) => Text(
          'Failed :',
          style: TextStyle(color: Colors.red),
        ),
        subtitle: (_) => Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
        leading: (_) => Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    else
      BotToast.showNotification(
        trailing: (_) => Icon(
          Icons.arrow_forward_ios,
          color: Colors.teal,
        ),
        title: (_) => Text(
          'Success :',
          style: TextStyle(color: Colors.teal),
        ),
        subtitle: (_) => Text(
          message,
          style: TextStyle(color: Colors.teal),
        ),
        leading: (_) => Icon(
          Icons.done,
          color: Colors.teal,
        ),
      );
  }

  //method for getting the user type as integer value
  static int getUserType(UserType userType) {
    switch (userType) {
      case UserType.USER_TYPE_CLIENT:
        return Constants.USER_TYPE_CLIENT;
      case UserType.USER_TYPE_MERCHANT:
        return Constants.USER_TYPE_MERCHANT;
      default:
        return -1;
    }
  }

  //method for getting the order status as integer value
  static int getOrderStatus(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.ORDER_STATUS_PENDING:
        return Constants.ORDER_STATUS_PENDING;
      case OrderStatus.ORDER_STATUS_APPROVED:
        return Constants.ORDER_STATUS_APPROVED;
      case OrderStatus.ORDER_STATUS_REJECTED:
        return Constants.ORDER_STATUS_REJECTED;
      default:
        return -1;
    }
  }

  // method for setting the app lang.
  static void changeAppLang(String lang) {
    switch (lang) {
      case 'ar':
        AppShared.appLang = ar;
        break;
      case 'en':
        AppShared.appLang = en;
        break;
    }
  }
}
