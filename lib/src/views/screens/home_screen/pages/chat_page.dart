import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChatPageBody();
  }
}

class ChatPageBody extends StatefulWidget {
  @override
  _ChatPageBodyState createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
//  UserController _userController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _userController = UserController.instance;
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Container();
  }
}
