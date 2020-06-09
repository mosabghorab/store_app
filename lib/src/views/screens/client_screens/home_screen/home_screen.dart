import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/client_screens_notifiers/home_screen_notifiers/home_screen_notifiers.dart';
import 'package:storeapp/src/views/components/parent_component.dart';
import 'package:storeapp/src/views/screens/client_screens/home_screen/pages/cart_page.dart';
import 'package:storeapp/src/views/screens/client_screens/home_screen/pages/home_page.dart';
import 'package:storeapp/src/views/screens/client_screens/home_screen/pages/others_page.dart';
import 'package:storeapp/src/views/screens/client_screens/home_screen/pages/profile_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<HomeScreenNotifiers>(
        create: (BuildContext context) => HomeScreenNotifiers(),
        child: HomeScreenBody(),
      ),
    );
  }
}

// ignore: must_be_immutable
class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  HomeScreenNotifiers _homeScreenNotifiers;

  PageController _pageController;
  List _pagesTitles = [
    'Home',
    'Cart',
    'Others',
    'Profile',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _homeScreenNotifiers =
        Provider.of<HomeScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: false,
        title: Selector<HomeScreenNotifiers, int>(
          selector: (_, value) => value.pageIndex,
          builder: (_, pageIndex, __) => Text(
            _pagesTitles[pageIndex],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          Selector<HomeScreenNotifiers, int>(
              selector: (_, value) => value.pageIndex,
              builder: (_, pageIndex, __) => pageIndex == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: InkWell(
                        onTap: () {
//                          Navigator.pushNamed(
//                            context,
//                            Constants.SCREENS_SEARCH_BY_COUNTRY_SCREEN,
//                          );
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container())
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  HomePage(),
                  CartPage(),
                  OthersPage(),
                  ProfilePage(),
                ],
                onPageChanged: (pageIndex) {
                  _homeScreenNotifiers.pageIndex = pageIndex;
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Selector<HomeScreenNotifiers, int>(
        selector: (_, value) => value.pageIndex,
        builder: (_, pageIndex, __) => Container(
          child: BottomNavigationBar(
            currentIndex: pageIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 28,
                  color: pageIndex == 0 ? Colors.blue : Colors.grey[300],
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 28,
                  color: pageIndex == 1 ? Colors.blue : Colors.grey[300],
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.card_travel,
                  size: 28,
                  color: pageIndex == 2 ? Colors.blue : Colors.grey[300],
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 28,
                  color: pageIndex == 3 ? Colors.blue : Colors.grey[300],
                ),
                title: Text(''),
              ),
            ],
            onTap: (pageIndex) {
              _pageController.jumpToPage(pageIndex);
            },
          ),
        ),
      ),
    );
  }
}
