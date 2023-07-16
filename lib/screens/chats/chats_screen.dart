import 'package:cached_network_image/cached_network_image.dart';
import 'package:footsie/api.dart';
import 'package:footsie/constants.dart';
import 'package:footsie/models/Chat.dart';
import 'package:footsie/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:footsie/util/reg_util.dart';
import 'dart:convert';
import 'components/chat_card.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreen createState() => _ChatsScreen();
}

class _ChatsScreen extends State<ChatsScreen>
    with SingleTickerProviderStateMixin {
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
    // 更新自己的位置
    // 链接 websocket
  }

  AppBar buildAppBar() {
    final u = jsonDecode(Instances.sp.getString('userinfo') ?? '');
    return AppBar(
      automaticallyImplyLeading: true,
      // leading: Stack(
      //   children: [
      //     CircleAvatar(
      //       radius: 20,
      //       child: ClipOval(
      //           child: CachedNetworkImage(
      //         imageUrl: getAvatar(avatar: u['email']),
      //         width: 40,
      //         height: 40,
      //       )),
      //     ),
      //     Positioned(
      //       right: 0,
      //       bottom: 0,
      //       child: Container(
      //         height: 12,
      //         width: 12,
      //         decoration: BoxDecoration(
      //           color: kPrimaryColor,
      //           shape: BoxShape.circle,
      //           border: Border.all(
      //               color: Theme.of(context).scaffoldBackgroundColor, width: 2),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      title: Text(u['name']),
      actions: const [
        Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.add,
              size: 25,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
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
      ),
      // bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}
