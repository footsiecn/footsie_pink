import 'dart:convert';

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
  var content = '';

  @override
  void initState() {
    super.initState();

    widget.stream.listen(
      (data) {
        setState(() {
          msgList.add(jsonDecode(data));
        });
      },
      onDone: () {
        print('ok');
      },
      onError: (err, stack) {
        print('err');
      },
    );
    // 查询数据库，暂时无
  }

  Widget buildCommentInput(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        color: Theme.of(context).colorScheme.background,
        child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(200, 200, 200, 0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          content = value;
                        });
                      },
                      style: const TextStyle(fontSize: 18),
                      textInputAction: TextInputAction.send,
                      keyboardType: TextInputType.multiline,
                      onEditingComplete: () {
                        //点击发送调用
                        submit();
                      },
                      decoration: const InputDecoration(
                        hintText: 'duang~',
                        isDense: true,
                        contentPadding: EdgeInsets.only(
                            left: 10, top: 2, bottom: 2, right: 10),
                        border: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      minLines: 1,
                      maxLines: 5,
                    )),
                SizedBox(
                  width: 80,
                  child: TextButton(
                    onPressed: () {
                      submit();
                    },
                    child: const Text(
                      "发射",
                    ),
                  ),
                )
              ],
            )));
  }

  String wiredData(msg) {
    final c = msg;
    final u = jsonDecode(Instances.sp.getString('userinfo') ?? '');
    final uid = u['_id'];
    final tid = widget.data['_id'];
    final datastr = '{"uid":"$uid", "tid": "$tid", "content": "$c", "cmd":1}';
    return datastr;
  }

  submit() {
    final datastr = wiredData(content);

    print(datastr);

    widget.channel.sink.add(datastr);
    msgList.add(jsonDecode(datastr));
    setState(() {});
  }

  Widget showData() {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        return Text(
          snapshot.hasData
              ? '${snapshot.data == 'ok' ? '在线' : snapshot.data}'
              : '',
        );
      },
    );
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
                itemCount: msgList.length,
                itemBuilder: (context, index) =>
                    Message(message: msgList[index],data: widget.data,),
              ),
            ),
          ),
          // showData(),
          buildCommentInput(context),
        ],
      ),
    );
  }
}
