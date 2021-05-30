import 'package:flutter/material.dart';
import 'package:testosocial2/database/method.dart';
import 'package:testosocial2/pages/home.dart';
import 'package:testosocial2/widget/header.dart';
import 'package:testosocial2/widget/progress.dart';
import 'package:testosocial2/database/comment.dart';

class Comments extends StatefulWidget {
  final String? postId;
  final String? postOwnerId;
  final String? postMediaUrl;
  final String? photoUrl;

  Comments({
    this.postId,
    this.postOwnerId,
    this.postMediaUrl,
    this.photoUrl,
  });

  @override
  CommentsState createState() => CommentsState(
        postId: this.postId,
        postOwnerId: this.postOwnerId,
        postMediaUrl: this.postMediaUrl,
      );
}

class CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();
  final String? postId;
  final String? postOwnerId;
  final String? postMediaUrl;
  bool? posted = false;

  CommentsState({
    this.postId,
    this.postOwnerId,
    this.postMediaUrl,
  });

  setPosted() {
    setState(() {
      posted = false;
    });
  }

  ListTile buildInsertComment() {
    return ListTile(
      title: TextFormField(
        controller: commentController,
        decoration: InputDecoration(labelText: "Write a comment..."),
      ),
      trailing: OutlineButton(
        onPressed: () {
          postComment(currentUser.id, commentController.text, postId!);
          posted = true;
        },
        borderSide: BorderSide.none,
        child: Text("Post"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: "Comments", removeBackButton: true),
      body: Column(
        children: <Widget>[
          buildListComment(), 
          Divider(),
          buildInsertComment(),
        ],
      ),
    );
  }

  buildListComment() {
    return FutureBuilder(
      future: getPostComment(postId!), 
      builder: (context, AsyncSnapshot<List<CommentDB>> snapshot) {
        if(!snapshot.hasData) {
          return circularProgress();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  snapshot.data![index].photoUrl!,
                ),
                
              ),
              title: Text(snapshot.data![index].codMittente!),
              subtitle: Text(snapshot.data![index].text!),
            );
          },
          
          );
    });
}

}
