import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  final String userName;
  final String imageUrl;
  ChatBubble(this.message, this.userName, this.imageUrl, this.isMe, {this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft:
                          !isMe ? Radius.circular(0) : Radius.circular(12),
                      bottomRight:
                          isMe ? Radius.circular(0) : Radius.circular(12)),
                  color:
                      isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                ),
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                padding: EdgeInsets.all(10),
                width: 150,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width: 150,
                        child: Text(
                          userName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: isMe ? TextAlign.end : TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        width: 150,
                        child: Text(
                          message,
                          style: isMe
                              ? TextStyle(color: Colors.black)
                              : TextStyle(
                                  color: Theme.of(context)
                                      .accentTextTheme
                                      .headline1
                                      .color),
                          textAlign: isMe ? TextAlign.end : TextAlign.start,
                        ),
                      ),
                    ]),
              ),
              Positioned(
                top: -15,
                left: isMe ? null : 130,
                right: isMe ? 130 : null,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ],
          ),
        ]);
  }
}
