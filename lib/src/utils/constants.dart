//||... Class for all constants inside the app ...||

class Constants {
// start : ||... APP_NAME ...||
  static const String APP_NAME = 'StoreApp';
// end : ||... APP_NAME ...||

//           ||-------------------------------------------||
// start : ||... SCREENS_NAMES ...||
  //< Merchant Screens >
  static const String SCREENS_DASHBOARD_SCREEN = 'DashboardScreen';
  static const String SCREENS_PRODUCTS_SCREEN = 'ProductsScreen';
  static const String SCREENS_CREATE_PRODUCT_SCREEN = 'CreateProductScreen';
  static const String SCREENS_ORDERS_SCREEN = 'OrdersScreen';

  //</ Merchant Screens >

//      ||.............||

  //< Client Screens >
  static const String SCREENS_HOME_SCREEN = 'HomeScreen';
  static const String SCREENS_PRODUCT_DETAILS_SCREEN = 'ProductDetailsScreen';
  static const String SCREENS_BILL_SCREEN = 'BillScreen';

  //</ Client Screens >

//      ||.............||

  //< Shared Screens >

  //</ Shared Screens >

  //      ||.............||

  //< Other Screens >
  static const String SCREENS_SIGN_IN_SCREEN = 'SignInScreen';
  static const String SCREENS_SIGN_UP_SCREEN = 'SignUpScreen';
  static const String SCREENS_SPLASH_SCREEN = 'SplashScreen';
  //</ Other Screens >

// end : ||... SCREENS_NAMES ...||

//           ||-------------------------------------------||

// start : ||... SHARED_PREFERENCES ...||
  static const String SHARED_IS_LOGIN = 'isLogin';
  static const bool SHARED_IS_LOGIN_DEFAULT_VALUE = false;

  static const String SHARED_IS_REMEMBER_ME = 'isRememberMe';
  static const bool SHARED_REMEMBER_ME_DEFAULT_VALUE = false;

  static const String SHARED_APP_LANG = 'appLang';
  static const String SHARED_APP_LANG_DEFAULT_VALUE = 'en';

  static const String SHARED_USER_ID = 'userId';
  static const int SHARED_USER_ID_DEFAULT_VALUE = -1;
// end : ||... SHARED_PREFERENCES ...||

//           ||-------------------------------------------||

// start : ||... API ...||

// end : ||... API ...||

//           ||-------------------------------------------||

// start : ||... ASSETS ...||
  static const String ASSETS_IMAGES_PATH = 'assets/images/';
// end : ||... ASSETS ...||

//           ||-------------------------------------------||

// start : ||... INTEGER VALUES ...||
  // User Type
  static const int USER_TYPE_CLIENT = 1;
  static const int USER_TYPE_MERCHANT = 2;
  // Image Source
  static const int IMAGE_SOURCE_GALLERY = 1;
  static const int IMAGE_SOURCE_CAMERA = 2;
  // Order Status
  static const int ORDER_STATUS_PENDING = 1;
  static const int ORDER_STATUS_REJECTED = 2;
  static const int ORDER_STATUS_APPROVED = 3;
// end : ||... INTEGER VALUES ...||

//           ||-------------------------------------------||

// start : ||... APP DATABASE ...||
  static const String APP_DATABASE_NAME = 'store.db';

  //< Tables Creation Queries >
  // Cart Products Table Creation
  static const String APP_DATABASE_TABLE_CART_PRODUCTS_CREATION_QUERY =
      'CREATE TABLE $APP_DATABASE_TABLE_CART_PRODUCTS'
      ' ($APP_DATABASE_FIELD_CART_PRODUCTS_ID INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' $APP_DATABASE_FIELD_CART_PRODUCTS_MERCHANT_ID INTEGER,'
      ' $APP_DATABASE_FIELD_CART_PRODUCTS_PRODUCT_ID INTEGER,'
      ' $APP_DATABASE_FIELD_CART_PRODUCTS_QUANTITY INTEGER)';

  //</ Tables Creation Queries >

// < TABLES >
  static const String APP_DATABASE_TABLE_CART_PRODUCTS = 'CartProducts';
// </ TABLES >

// < FIELDS >
  // Cart Products
  static const String APP_DATABASE_FIELD_CART_PRODUCTS_ID = 'id';
  static const String APP_DATABASE_FIELD_CART_PRODUCTS_MERCHANT_ID =
      'merchantId';
  static const String APP_DATABASE_FIELD_CART_PRODUCTS_PRODUCT_ID = 'productId';
  static const String APP_DATABASE_FIELD_CART_PRODUCTS_QUANTITY = 'quantity';

// </ FIELDS >

// end : ||... APP DATABASE ...||

//           ||-------------------------------------------||

// start : ||... FIREBASE ...||

  //start:|. COLLECTIONS .|

  static const String FIREBASE_COLLECTIONS_USERS = 'Users';
  static const String FIREBASE_COLLECTIONS_ADDRESSES = 'ADDRESSES';
  static const String FIREBASE_COLLECTIONS_PRODUCTS = 'Products';
  static const String FIREBASE_COLLECTIONS_ORDERS = 'Orders';
  static const String FIREBASE_COLLECTIONS_CATEGORIES = 'Categories';

  static const String FIREBASE_SUB_COLLECTIONS_ORDER_PRODUCTS = 'OrderProducts';

  //end:|. COLLECTIONS .|

  // ||------------------------||

  //start:|. FIELDS .|

  // USERS
  static const String FIREBASE_USERS_FIELD_UID = 'uid';
  static const String FIREBASE_USERS_FIELD_NAME = 'name';
  static const String FIREBASE_USERS_FIELD_EMAIL = 'email';
  static const String FIREBASE_USERS_FIELD_PASSWORD = 'password';
  static const String FIREBASE_USERS_FIELD_PERSONAL_IMAGE = 'personalImage';
  static const String FIREBASE_USERS_FIELD_TYPE = 'type';

  // CATEGORIES
  static const String FIREBASE_CATEGORIES_FIELD_ID = 'id';
  static const String FIREBASE_CATEGORIES_FIELD_NAME = 'name';

  // PRODUCTS
  static const String FIREBASE_PRODUCTS_FIELD_ID = 'id';
  static const String FIREBASE_PRODUCTS_FIELD_NAME = 'name';
  static const String FIREBASE_PRODUCTS_FIELD_PRICE = 'price';
  static const String FIREBASE_PRODUCTS_FIELD_MERCHANT_ID = 'merchantId';
  static const String FIREBASE_PRODUCTS_FIELD_CATEGORY_ID = 'categoryId';
  static const String FIREBASE_PRODUCTS_FIELD_IMAGE = 'Image';
  static const String FIREBASE_PRODUCTS_FIELD_DESCRIPTION = 'description';

  // ORDERS
  static const String FIREBASE_ORDERS_FIELD_ID = 'id';
  static const String FIREBASE_ORDERS_FIELD_MERCHANT_ID = 'merchantId';
  static const String FIREBASE_ORDERS_FIELD_CLIENT_ID = 'clientId';
  static const String FIREBASE_ORDERS_FIELD_ADDRESS_ID = 'addressId';
  static const String FIREBASE_ORDERS_FIELD_DATE = 'date';
  static const String FIREBASE_ORDERS_FIELD_STATUS = 'status';

  // ADDRESSES
  static const String FIREBASE_ADDRESSES_FIELD_ID = 'id';
  static const String FIREBASE_ADDRESSES_FIELD_CLIENT_ID = 'clientId';
  static const String FIREBASE_ADDRESSES_FIELD_NAME = 'name';
  static const String FIREBASE_ADDRESSES_FIELD_COUNTRY = 'country';
  static const String FIREBASE_ADDRESSES_FIELD_CITY = 'city';
  static const String FIREBASE_ADDRESSES_FIELD_STREET_NO = 'streetNo';
  static const String FIREBASE_ADDRESSES_FIELD_HOUSE_NO = 'houseNo';

  // OrderProducts
  static const String FIREBASE_OrderProducts_FIELD_ID = 'id';
  static const String FIREBASE_OrderProducts_FIELD_PRODUCT_ID = 'productId';
  static const String FIREBASE_OrderProducts_FIELD_QUANTITY = 'quantity';

  //end:|. FIELDS .|

  // start |. STORAGE .|
  static const String FIREBASE_STORAGE_IMAGES_BASE_PATH = 'images/';
  static const String FIREBASE_STORAGE_USERS_IMAGES_PATH =
      '${FIREBASE_STORAGE_IMAGES_BASE_PATH}users/';
  static const String FIREBASE_STORAGE_PRODUCTS_IMAGES_PATH =
      '${FIREBASE_STORAGE_IMAGES_BASE_PATH}products/';
// end |. STORAGE .|

// end : ||... FIREBASE ...||

}
