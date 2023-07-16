import 'package:footsie/constants.dart';
import 'package:flutter/material.dart';
import 'package:footsie/util/reg_util.dart';
import 'dart:convert';

import 'components/body.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    final u = jsonDecode(Instances.sp.getString('userinfo') ?? '');
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "消息"),
        const BottomNavigationBarItem(icon: Icon(Icons.people), label: "身边"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            child: Image.network(getAvatar(avatar: u['email'])),
          ),
          label: "我的",
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("身边"),
    );
  }
}
