import 'package:footsie/api.dart';
import 'package:footsie/constants.dart';
import 'package:footsie/models/Chat.dart';
import 'package:footsie/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'chat_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> with SingleTickerProviderStateMixin {
  List userList = [];
  Map userinfo = {};

  getUserList() async {
    final u = jsonDecode(Instances.sp.getString('userinfo') ?? '');
    userList = jsonDecode((await getUsers(u['_id'])).data)['data'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   padding: EdgeInsets.fromLTRB(
        //       kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
        //   color: kPrimaryColor,
        //   child: Row(
        //     children: [
        //       FillOutlineButton(press: () {}, text: "Recent Message"),
        //       SizedBox(width: kDefaultPadding),
        //       FillOutlineButton(
        //         press: () {},
        //         text: "Active",
        //         isFilled: false,
        //       ),
        //     ],
        //   ),
        // ),
        Expanded(
          child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) => ChatCard(
              chat: userList[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesScreen(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
