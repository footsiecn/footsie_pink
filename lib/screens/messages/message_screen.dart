import 'package:cached_network_image/cached_network_image.dart';
import 'package:footsie/constants.dart';
import 'package:footsie/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:footsie/util/reg_util.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'components/chat_input_field.dart';
import 'components/message.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen(
      {Key? key,
      required this.channel,
      required this.stream,
      required this.data})
      : super(key: key);

  //   const ChatCard({
  //   Key? key,
  //   required this.chat,
  //   required this.press,
  // }) : super(key: key);

  final Map data;
  final WebSocketChannel channel;
  final Stream stream;

  @override
  _MessagesScreen createState() => _MessagesScreen();
}

class _MessagesScreen extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
            radius: 20,
            child: ClipOval(
                child: CachedNetworkImage(
              imageUrl: getAvatar(avatar: widget.data['email']),
              width: 40,
              height: 40,
            )),
          ),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data['name'],
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }

  final msgList = [];

   @override
  void initState() {
    super.initState();
    // 查询数据库，暂时无
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ListView.builder(
                itemCount: demeChatMessages.length,
                itemBuilder: (context, index) =>
                    Message(message: demeChatMessages[index]),
              ),
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
  }
}
