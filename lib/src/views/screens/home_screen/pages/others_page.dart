import 'package:flutter/material.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';

class OthersPage extends StatefulWidget {
  @override
  _OthersPageState createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[100],
        padding: AppStyles.defaultPadding3,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
//                      Navigator.pushNamed(context,
//                          Constants.SCREENS_CONTINENT_QUESTIONS_SCREEN);
                    },
                    child: Container(
                      height: AppShared.screenUtil.setHeight(700),
                      padding: AppStyles.defaultPadding4,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('Questions'),
                          Image.asset(
                            '${Constants.ASSETS_IMAGES_PATH}questions.png',
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
//                      Navigator.pushNamed(
//                          context, Constants.SCREENS_CONTINENT_VIDEOS_SCREEN);
                    },
                    child: Container(
                      height: AppShared.screenUtil.setHeight(700),
                      padding: AppStyles.defaultPadding4,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('Videos'),
                          Image.asset(
                            '${Constants.ASSETS_IMAGES_PATH}videos.png',
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
//                    Navigator.pushNamed(
//                        context, Constants.SCREENS_CONTINENT_ARTICLES_SCREEN);
                  },
                  child: Container(
                    height: AppShared.screenUtil.setHeight(700),
                    width: 250,
                    padding: AppStyles.defaultPadding4,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Articles'),
                        Image.asset(
                          '${Constants.ASSETS_IMAGES_PATH}online_pages.png',
                          width: 150,
                          height: 150,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
