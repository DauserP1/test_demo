import 'package:flutter/material.dart';
import 'package:habini/screens/comments_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _auth = FirebaseAuth.instance;
final _firebase = FirebaseFirestore.instance;

User logedInUser;

class KTextField extends StatelessWidget {
  KTextField({
    this.labelText,
    this.keyBordType,
    this.inputFormatters,
    this.hidden,
    this.icon,
    this.onChange,
    this.validator,
  });

  final labelText;
  final keyBordType;
  final inputFormatters;
  final hidden;
  final icon;
  final onChange;
  final validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hidden,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(90.0),
          ),
          borderSide: BorderSide(color: Colors.blue, width: 0.5),
        ),
        prefixIcon: icon,
        labelText: labelText,
      ),
      keyboardType: keyBordType,
      inputFormatters: inputFormatters,
      onChanged: onChange,
      validator: validator,
    );
  }
}

class KmaterialButton extends StatelessWidget {
  KmaterialButton({this.onPressed, this.label, this.color});
  final onPressed;
  final label;
  final color;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5.0,
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 200.0,
        height: 42.0,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class KPostContainer extends StatefulWidget {
  final String content;
  int votes = 0;
  final date;
  int numberOfComments = 0;
  int downCounter = 0;
  int upCounter = 0;
  final postId;

  KPostContainer({
    this.postId,
    this.content,
    this.votes,
    this.date,
    this.numberOfComments,
  });

  @override
  _KPostContainerState createState() => _KPostContainerState();
}

class _KPostContainerState extends State<KPostContainer> {
  @override
  bool downVote = false;
  bool upVote = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                child: CircleAvatar(),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[Text(''), DropdownButton<FlatButton>()]),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Opacity(
            opacity: 0.5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 0.5,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.content,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_drop_up,
                            color: upVote ? Colors.red : Colors.black,
                          ),
                          tooltip: 'Up vote',
                          iconSize: 30,
                          onPressed: () {
                            setState(() {
                              downVote = false;
                              if (upVote == true) {
                                widget.upCounter = 0;
                                widget.votes--;
                                upVote = false;
                              } else {
                                if (widget.downCounter == 1) {
                                  widget.votes++;
                                  widget.downCounter = 0;
                                }
                                widget.upCounter = 1;
                                widget.votes++;
                                upVote = true;
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: downVote ? Colors.red : Colors.black,
                          ),
                          tooltip: 'Down vote',
                          iconSize: 30,
                          onPressed: () {
                            setState(() {
                              upVote = false;
                              if (downVote == true) {
                                widget.downCounter = 0;
                                widget.votes++;
                                downVote = false;
                              } else {
                                if (widget.upCounter == 1) {
                                  widget.votes--;
                                  widget.upCounter = 0;
                                }
                                widget.downCounter = 1;
                                widget.votes--;
                                downVote = true;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    Text(
                      widget.votes.toString(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0, bottom: 3.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.comment),
                      tooltip: 'Comment',
                      iconSize: 28,
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CommentsScreen(
                                postId: widget.postId,
                                postContent: widget.content,
                                postVotes: widget.votes,
                                numberOfComments: widget.numberOfComments,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                    Text(
                      '$NumberOfComments',
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class KComment extends StatefulWidget {
  final String content;
  int votes = 0;
  final date;
  int downCounter = 0;
  int upCounter = 0;

  KComment({
    this.votes,
    this.date,
    this.content,
  });

  @override
  _KCommentState createState() => _KCommentState();
}

class _KCommentState extends State<KComment> {
  @override
  bool downVote = false;
  bool upVote = false;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.grey[200],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                child: CircleAvatar(
                  radius: 16,
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("20 mins ago"),
                    DropdownButton<FlatButton>()
                  ]),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.content,
                      style: TextStyle(fontSize: 15),
                      softWrap: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_drop_up,
                  color: upVote ? Colors.blue : Colors.black,
                ),
                tooltip: 'Up vote',
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    downVote = false;
                    if (upVote == true) {
                      widget.upCounter = 0;
                      widget.votes--;
                      upVote = false;
                    } else {
                      if (widget.downCounter == 1) {
                        widget.votes++;
                        widget.downCounter = 0;
                      }
                      widget.upCounter = 1;
                      widget.votes++;
                      upVote = true;
                    }
                  });
                },
              ),
              Text(
                widget.votes.toString(),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: downVote ? Colors.blue : Colors.black,
                ),
                tooltip: 'Down vote',
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    upVote = false;
                    if (downVote == true) {
                      widget.downCounter = 0;
                      widget.votes++;
                      downVote = false;
                    } else {
                      if (widget.upCounter == 1) {
                        widget.votes--;
                        widget.upCounter = 0;
                      }
                      widget.downCounter = 1;
                      widget.votes--;
                      downVote = true;
                    }
                  });
                },
              ),
            ],
          ),
          Opacity(
            opacity: 0.5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 1,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
