import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/category_controller.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/product_controller.dart';
import 'package:storeapp/src/models/local_models/category.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/client_screens_notifiers/home_screen_notifiers/pages_notifiers/home_page_notifiers.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/views/components/status_components/loading_component.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageNotifiers>(
      create: (_) => HomePageNotifiers(),
      child: HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  HomePageNotifiers _homePageNotifiers;
  CategoryController _categoryController;
  ProductController _productController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryController = CategoryController.instance;
    _productController = ProductController.instance;
    _homePageNotifiers = Provider.of<HomePageNotifiers>(context, listen: false);
    _init();
  }

  void _init() async {
    _homePageNotifiers.categories =
        await _categoryController.getAllCategories();
    _homePageNotifiers.categories.insert(0, Category(name: 'All'));
    _homePageNotifiers.products = await _productController.getAllProducts();
    _homePageNotifiers.categoriesIsLoading = false;
    _homePageNotifiers.productsIsLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Container(
      padding: AppStyles.defaultPadding4,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 3,
              child: Container(
                width: _mediaQuery.size.width * 0.90,
                padding: AppStyles.defaultPadding2,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Search about product..',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text('Categories'),
            ),
            SizedBox(
              height: 15,
            ),
            Selector<HomePageNotifiers, bool>(
              selector: (_, value) => value.categoriesIsLoading,
              builder: (_, categoriesIsLoading, __) => Container(
                height: 70,
                alignment: AlignmentDirectional.center,
                child: categoriesIsLoading
                    ? Container(
                        child: Center(
                          child: LoadingComponent(),
                        ),
                      )
                    : _homePageNotifiers.categories.isEmpty
                        ? Container(
                            child: Center(
                              child: Text('No Categories Found!'),
                            ),
                          )
                        : Container(
                            height: 50,
                            child: ListView.builder(
                              itemCount: _homePageNotifiers.categories.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) =>
                                  Selector<HomePageNotifiers, int>(
                                selector: (_, value) => value.selectedCategory,
                                builder: (_, selectedCategory, __) => InkWell(
                                  onTap: () {
                                    _homePageNotifiers.selectedCategory = index;
                                  },
                                  child: Container(
                                    height: 15,
                                    width: 100,
                                    child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        decoration: BoxDecoration(
                                          color: selectedCategory == index
                                              ? Colors.blue
                                              : Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: Text(
                                          _homePageNotifiers
                                              .categories[index].name,
                                          style: TextStyle(
                                            color: selectedCategory == index
                                                ? Colors.white
                                                : Colors.blue,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text('Products'),
            ),
            SizedBox(
              height: 15,
            ),
            Selector<HomePageNotifiers, bool>(
              selector: (_, value) => value.productsIsLoading,
              builder: (_, productsIsLoading, __) => productsIsLoading
                  ? Container(
                      child: Center(
                        child: LoadingComponent(),
                      ),
                    )
                  : _homePageNotifiers.products.isEmpty
                      ? Container(
                          child: Center(
                            child: Text('No Products Found!'),
                          ),
                        )
                      : Container(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: _homePageNotifiers.products.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) => Column(
                              children: <Widget>[
                                Image.memory(
                                  base64Decode(
                                      _homePageNotifiers.products[index].image),
                                ),
                                Text(
                                    '${_homePageNotifiers.products[index].name}'),
                              ],
                            ),
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
