//||... Class for all constants inside the app ...||

class Constants {
// start : ||... APP_NAME ...||
  static const String APP_NAME = 'StoreApp';
// end : ||... APP_NAME ...||

//           ||-------------------------------------------||
// start : ||... SCREENS_NAMES ...||
  //< Merchant Screens >

  //</ Merchant Screens >

//      ||.............||

  //< Client Screens >
  static const String SCREENS_HOME_SCREEN = 'HomeScreen';
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
  // Users Table Creation
  static const String APP_DATABASE_TABLE_USERS_CREATION_QUERY =
      'CREATE TABLE $APP_DATABASE_TABLE_USERS'
      ' ($APP_DATABASE_FIELD_USERS_ID INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' $APP_DATABASE_FIELD_USERS_NAME TEXT,'
      ' $APP_DATABASE_FIELD_USERS_EMAIL TEXT,'
      ' $APP_DATABASE_FIELD_USERS_PASSWORD TEXT,'
      ' $APP_DATABASE_FIELD_USERS_PERSONAL_IMAGE TEXT,'
      ' $APP_DATABASE_FIELD_USERS_TYPE INTEGER)';

  // Products Table Creation
  static const String APP_DATABASE_TABLE_PRODUCTS_CREATION_QUERY =
      'CREATE TABLE $APP_DATABASE_TABLE_PRODUCTS'
      ' ($APP_DATABASE_FIELD_PRODUCTS_ID INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' $APP_DATABASE_FIELD_PRODUCTS_NAME TEXT,'
      ' $APP_DATABASE_FIELD_PRODUCTS_PRICE REAL,'
      ' $APP_DATABASE_FIELD_PRODUCTS_MERCHANT_ID INTEGER ,'
      ' $APP_DATABASE_FIELD_PRODUCTS_IMAGE TEXT,'
      ' $APP_DATABASE_FIELD_PRODUCTS_DESCRIPTION TEXT,'
      'FOREIGN KEY($APP_DATABASE_FIELD_PRODUCTS_MERCHANT_ID) REFERENCES $APP_DATABASE_TABLE_USERS($APP_DATABASE_FIELD_USERS_ID),';

  // Addresses Table Creation
  static const String APP_DATABASE_TABLE_ADDRESSES_CREATION_QUERY =
      'CREATE TABLE $APP_DATABASE_TABLE_ADDRESSES'
      ' ($APP_DATABASE_FIELD_ADDRESSES_ID INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' $APP_DATABASE_FIELD_ADDRESSES_NAME TEXT,'
      ' $APP_DATABASE_FIELD_ADDRESSES_CLIENT_ID INTEGER,'
      ' $APP_DATABASE_FIELD_ADDRESSES_COUNTRY TEXT,'
      ' $APP_DATABASE_FIELD_ADDRESSES_CITY TEXT,'
      ' $APP_DATABASE_FIELD_ADDRESSES_STREET_NO INTEGER,'
      ' $APP_DATABASE_FIELD_ADDRESSES_HOUSE_NO INTEGER,'
      'FOREIGN KEY($APP_DATABASE_FIELD_ADDRESSES_CLIENT_ID) REFERENCES $APP_DATABASE_TABLE_USERS($APP_DATABASE_FIELD_USERS_ID),';

  // Cart Products Table Creation
  static const String APP_DATABASE_TABLE_CART_PRODUCTS_CREATION_QUERY =
      'CREATE TABLE $APP_DATABASE_TABLE_CART_PRODUCTS'
      ' ($APP_DATABASE_FIELD_ADDRESSES_ID INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' $APP_DATABASE_FIELD_ADDRESSES_NAME TEXT,'
      ' $APP_DATABASE_FIELD_ADDRESSES_CLIENT_ID INTEGER,'
      ' $APP_DATABASE_FIELD_ADDRESSES_COUNTRY TEXT,'
      ' $APP_DATABASE_FIELD_ADDRESSES_CITY TEXT,'
      ' $APP_DATABASE_FIELD_ADDRESSES_STREET_NO INTEGER,'
      ' $APP_DATABASE_FIELD_ADDRESSES_HOUSE_NO INTEGER,';

  //</ Tables Queries >

// < TABLES >
  static const String APP_DATABASE_TABLE_USERS = 'Users';
  static const String APP_DATABASE_TABLE_PRODUCTS = 'Products';
  static const String APP_DATABASE_TABLE_ADDRESSES = 'Addresses';
  static const String APP_DATABASE_TABLE_ORDERS = 'Orders';
  static const String APP_DATABASE_TABLE_ORDERS_DETAILS = 'OrdersDetails';
  static const String APP_DATABASE_TABLE_CART_PRODUCTS = 'CartProducts';
// </ TABLES >

// < FIELDS >
  // Users
  static const String APP_DATABASE_FIELD_USERS_ID = 'id';
  static const String APP_DATABASE_FIELD_USERS_NAME = 'name';
  static const String APP_DATABASE_FIELD_USERS_TYPE = 'type';
  static const String APP_DATABASE_FIELD_USERS_EMAIL = 'email';
  static const String APP_DATABASE_FIELD_USERS_PASSWORD = 'password';
  static const String APP_DATABASE_FIELD_USERS_PERSONAL_IMAGE = 'personalImage';

  // Products
  static const String APP_DATABASE_FIELD_PRODUCTS_ID = 'id';
  static const String APP_DATABASE_FIELD_PRODUCTS_NAME = 'name';
  static const String APP_DATABASE_FIELD_PRODUCTS_PRICE = 'price';
  static const String APP_DATABASE_FIELD_PRODUCTS_MERCHANT_ID = 'merchantId';
  static const String APP_DATABASE_FIELD_PRODUCTS_DESCRIPTION = 'description';
  static const String APP_DATABASE_FIELD_PRODUCTS_IMAGE = 'image';

  // Addresses
  static const String APP_DATABASE_FIELD_ADDRESSES_ID = 'id';
  static const String APP_DATABASE_FIELD_ADDRESSES_CLIENT_ID = 'clientId';
  static const String APP_DATABASE_FIELD_ADDRESSES_NAME = 'name';
  static const String APP_DATABASE_FIELD_ADDRESSES_COUNTRY = 'country';
  static const String APP_DATABASE_FIELD_ADDRESSES_CITY = 'city';
  static const String APP_DATABASE_FIELD_ADDRESSES_STREET_NO = 'streetNo';
  static const String APP_DATABASE_FIELD_ADDRESSES_HOUSE_NO = 'houseNo';

  // Cart Products
  static const String APP_DATABASE_FIELD_CART_PRODUCTS_ID = 'id';
  static const String APP_DATABASE_FIELD_CART_PRODUCTS_CLIENT_ID = 'clientId';
  static const String APP_DATABASE_FIELD_CART_PRODUCTS_PRODUCT_ID = 'productId';
  static const String APP_DATABASE_FIELD_CART_PRODUCTS_QUANTITY = 'quantity';

  // Orders
  static const String APP_DATABASE_FIELD_ORDERS_ID = 'id';
  static const String APP_DATABASE_FIELD_ORDERS_CLIENT_ID = 'clientId';
  static const String APP_DATABASE_FIELD_ORDERS_STATUS = 'status';
  static const String APP_DATABASE_FIELD_ORDERS_DATE = 'date';

  // Orders Details
  static const String APP_DATABASE_FIELD_ORDERS_DETAILS_ID = 'id';
  static const String APP_DATABASE_FIELD_ORDERS_DETAILS_CLIENT_ID = 'clientId';
  static const String APP_DATABASE_FIELD_ORDERS_DETAILS_ORDER_ID = 'orderId';
  static const String APP_DATABASE_FIELD_ORDERS_DETAILS_PRODUCT_ID =
      'productId';

// </ FIELDS >

// end : ||... APP DATABASE ...||

//           ||-------------------------------------------||

// start : ||... FIREBASE ...||

  //start:|. COLLECTIONS .|

  //end:|. COLLECTIONS .|

  // ||------------------------||

  //start:|. FIELDS .|

  //end:|. FIELDS .|

  // start |. STORAGE .|

  // end |. STORAGE .|

// end : ||... FIREBASE ...||

}
