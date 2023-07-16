import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:footsie/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:footsie/util/reg_util.dart';

import '../../../constants.dart';
import 'audio_message.dart';
import 'text_message.dart';
import 'video_message.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
    required this.data,
  }) : super(key: key);
  final Map data;
  final Map message;

  @override
  Widget build(BuildContext context) {
    final u = jsonDecode(Instances.sp.getString('userinfo') ?? '');

    final isSender = u['_id'] == message['uid'];

    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender) ...[
            CircleAvatar(
            radius: 12,
            child: ClipOval(
                child: CachedNetworkImage(
              imageUrl: getAvatar(avatar: data['email']),
              width: 24,
              height: 24,
            )),
          ),
            const SizedBox(width: kDefaultPadding / 2),
          ],
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 0.75,
              vertical: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(isSender ? 1 : 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              message['content'],
              style: TextStyle(
                color: isSender
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          )
          // if (isSender) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;

  const MessageStatusDot({Key? key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return kErrorColor;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return kPrimaryColor;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status!),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
