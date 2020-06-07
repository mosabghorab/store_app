import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/home_screen_notifiers/pages_notifiers/home_page_notifiers.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homePageNotifiers = Provider.of<HomePageNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
