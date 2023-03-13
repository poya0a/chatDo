import 'dart:io';

import 'package:chat/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<AnimatedListState> _aniListKey = GlobalKey<AnimatedListState>();
  TextEditingController _textEditingController = TextEditingController();

  List<String> _chats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("CHAT DO"),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _aniListKey,
              reverse: true,
              itemBuilder:  _buildItem,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    controller: _textEditingController,
                    placeholder: "Send a message",
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                CupertinoButton(
                  onPressed: () {
                    _handleSubmitted(_textEditingController.text);
                  },
                  child: Text("Send"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(context, index, animation){
    return ChatMessage(_chats[index], animation: animation,);
  }

  void _handleSubmitted(String text) {
    print(text);
    _textEditingController.clear();
    _chats.insert(0, text);
    _aniListKey.currentState?.insertItem(0);
  }
}