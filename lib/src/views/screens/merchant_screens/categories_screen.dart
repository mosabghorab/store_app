import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/category_controller.dart';
import 'package:storeapp/src/models/local_models/category.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/merchant_screens_notifiers/categories_screen_notifiers.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/enums.dart';
import 'package:storeapp/src/utils/helpers.dart';
import 'package:storeapp/src/views/components/parent_component.dart';
import 'package:storeapp/src/views/components/status_components/loading_component.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<CategoriesScreenNotifiers>(
        create: (_) => CategoriesScreenNotifiers(),
        child: CategoriesScreenBody(),
      ),
    );
  }
}

class CategoriesScreenBody extends StatefulWidget {
  @override
  _CategoriesScreenBodyState createState() => _CategoriesScreenBodyState();
}

class _CategoriesScreenBodyState extends State<CategoriesScreenBody> {
  CategoriesScreenNotifiers _categoriesScreenNotifiers;
  CategoryController _categoryController;
  GlobalKey<FormState> _createCategoryFormState;
  GlobalKey<FormState> _editCategoryFormState;
  String _categoryName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createCategoryFormState = GlobalKey();
    _editCategoryFormState = GlobalKey();
    _categoryController = CategoryController.instance;
    _categoriesScreenNotifiers =
        Provider.of<CategoriesScreenNotifiers>(context, listen: false);
    _init();
  }

  void _init() async {
    _categoriesScreenNotifiers.categories =
        await _categoryController.getAllCategories();
    _categoriesScreenNotifiers.isLoading = false;
  }

  void _createCategory() async {
    if (!_createCategoryFormState.currentState.validate()) return;
    _createCategoryFormState.currentState.save();
    Navigator.pop(context);
    _categoriesScreenNotifiers.isLoading = true;
    try {
      int result = await _categoryController
          .createCategory(Category(name: _categoryName));
      _categoriesScreenNotifiers.categories =
          await _categoryController.getAllCategories();
      await Future.delayed(Duration(seconds: 1));
      _categoriesScreenNotifiers.isLoading = false;
      if (result > 0)
        Helpers.showMessage(
            'Category created successfully', MessageType.MESSAGE_SUCCESS);
      else
        Helpers.showMessage('Operation failed', MessageType.MESSAGE_FAILED);
    } catch (error) {
      _categoriesScreenNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

  void _updateCategory(int id) async {
    if (!_editCategoryFormState.currentState.validate()) return;
    _editCategoryFormState.currentState.save();
    Navigator.pop(context);
    _categoriesScreenNotifiers.isLoading = true;
    try {
      int result = await _categoryController.updateCategory(
          id, Category(name: _categoryName, id: id));
      _categoriesScreenNotifiers.categories =
          await _categoryController.getAllCategories();
      await Future.delayed(Duration(seconds: 1));
      _categoriesScreenNotifiers.isLoading = false;
      if (result > 0)
        Helpers.showMessage(
            'Category updated successfully', MessageType.MESSAGE_SUCCESS);
      else
        Helpers.showMessage('Operation failed', MessageType.MESSAGE_FAILED);
    } catch (error) {
      _categoriesScreenNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

  void _deleteCategory(index) async {
    Navigator.pop(context);
    _categoriesScreenNotifiers.isLoading = true;
    try {
      int result = await _categoryController
          .deleteCategory(_categoriesScreenNotifiers.categories[index].id);
      _categoriesScreenNotifiers.categories =
          await _categoryController.getAllCategories();
      await Future.delayed(Duration(seconds: 1));
      _categoriesScreenNotifiers.isLoading = false;
      if (result > 0)
        Helpers.showMessage(
            'Category deleted successfully', MessageType.MESSAGE_SUCCESS);
      else
        Helpers.showMessage('Operation failed', MessageType.MESSAGE_FAILED);
    } catch (error) {
      _categoriesScreenNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              child: Container(
                height: 170,
                padding: AppStyles.defaultPadding2,
                child: Form(
                  key: _createCategoryFormState,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text('Create new category')),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Category name'),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Category name is required';
                            else
                              return null;
                          },
                          onSaved: (value) {
                            _categoryName = value;
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
                              onPressed: _createCategory,
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
      body: Selector<CategoriesScreenNotifiers, bool>(
        selector: (_, value) => value.isLoading,
        builder: (_, isLoading, __) => Container(
          padding: AppStyles.defaultPadding2,
          child: isLoading
              ? Container(
                  child: Center(
                    child: LoadingComponent(),
                  ),
                )
              : _categoriesScreenNotifiers.categories.isEmpty
                  ? Container(
                      child: Center(
                        child: Text('No Categories Found!'),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _categoriesScreenNotifiers.categories.length,
                      itemBuilder: (_, index) => Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(_categoriesScreenNotifiers
                              .categories[index].name),
                          trailing: Container(
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text('Delete category'),
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
                                              _deleteCategory(index);
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
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => Dialog(
                                              child: Container(
                                                height: 170,
                                                padding:
                                                    AppStyles.defaultPadding2,
                                                child: Form(
                                                  key: _editCategoryFormState,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Container(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .centerStart,
                                                            child: Text(
                                                                'Update category')),
                                                        TextFormField(
                                                          initialValue:
                                                              _categoriesScreenNotifiers
                                                                  .categories[
                                                                      index]
                                                                  .name,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      'Category name'),
                                                          validator: (value) {
                                                            if (value.isEmpty)
                                                              return 'Category name is required';
                                                            else
                                                              return null;
                                                          },
                                                          onSaved: (value) {
                                                            _categoryName =
                                                                value;
                                                          },
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            FlatButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                'Cancel',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ),
                                                            FlatButton(
                                                              onPressed: () {
                                                                _updateCategory(
                                                                    _categoriesScreenNotifiers
                                                                        .categories[
                                                                            index]
                                                                        .id);
                                                              },
                                                              child: Text(
                                                                'Edit',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ));
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
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
