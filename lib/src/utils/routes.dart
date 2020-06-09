//||... File for app routes ...||
import 'package:flutter/cupertino.dart';
import 'package:storeapp/src/views/screens/client_screens/bill_screen.dart';
import 'package:storeapp/src/views/screens/client_screens/home_screen/home_screen.dart';
import 'package:storeapp/src/views/screens/client_screens/product_details_screen.dart';
import 'package:storeapp/src/views/screens/merchant_screens/categories_screen.dart';
import 'package:storeapp/src/views/screens/merchant_screens/create_product_screen.dart';
import 'package:storeapp/src/views/screens/merchant_screens/dashborad_screen.dart';
import 'package:storeapp/src/views/screens/merchant_screens/orders_screen.dart';
import 'package:storeapp/src/views/screens/merchant_screens/products_screen.dart';
import 'package:storeapp/src/views/screens/other_screens/sign_in_screen.dart';
import 'package:storeapp/src/views/screens/other_screens/sign_up_screen.dart';
import 'package:storeapp/src/views/screens/other_screens/splash_screen.dart';

import 'constants.dart';

Map<String, Widget Function(BuildContext context)> appRoutes = {
  Constants.SCREENS_HOME_SCREEN: (_) => HomeScreen(),
  Constants.SCREENS_SIGN_IN_SCREEN: (_) => SignInScreen(),
  Constants.SCREENS_SIGN_UP_SCREEN: (_) => SignUpScreen(),
  Constants.SCREENS_SPLASH_SCREEN: (_) => SplashScreen(),
  Constants.SCREENS_DASHBOARD_SCREEN: (_) => DashboardScreen(),
  Constants.SCREENS_CATEGORIES_SCREEN: (_) => CategoriesScreen(),
  Constants.SCREENS_PRODUCTS_SCREEN: (_) => ProductsScreen(),
  Constants.SCREENS_CREATE_PRODUCT_SCREEN: (_) => CreateProductScreen(),
  Constants.SCREENS_PRODUCT_DETAILS_SCREEN: (_) => ProductDetailsScreen(),
  Constants.SCREENS_BILL_SCREEN: (_) => BillScreen(),
  Constants.SCREENS_ORDERS_SCREEN: (_) => OrdersScreen(),
};
