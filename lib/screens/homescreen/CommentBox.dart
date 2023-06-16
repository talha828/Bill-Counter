import 'package:flutter/material.dart';

class CommentBox extends StatefulWidget {
  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 400,
      decoration: BoxDecoration(
        border: Border.all(
          color: _isFocused ? Colors.blue : Colors.purple,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        height: 20,
        width: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  onChanged: (value) {
                    setState(() {});
                  },
                  maxLength: 500,
                  maxLines: null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.purple.shade50,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: "Write a comment...",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(
                        color: Colors.purple,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // submit the comment
                  _textEditingController.clear();
                  _focusNode.unfocus();
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Icon(Icons.send, color: _textEditingController.text.isEmpty ? Colors.purple : Colors.blue),
                ),
              ),
              SizedBox(height: 20.0),

            ],

          ),
        ),

      ),

    );
  }
}