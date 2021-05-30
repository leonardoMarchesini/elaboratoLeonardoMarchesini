import 'package:flutter/material.dart';
import 'package:testosocial2/database/method.dart';
import 'package:testosocial2/models/user.dart';
import 'package:testosocial2/pages/comments.dart';
import 'package:testosocial2/pages/home.dart';
import 'package:testosocial2/utility/color.dart';
import 'package:testosocial2/widget/header.dart';
import 'package:testosocial2/widget/post.dart';
import 'package:testosocial2/widget/progress.dart';

int classicDance = 0;
int comedy = 0;
int sport = 0;
int neomelodica = 0;
int pop = 0;
int rock = 0;
bool isLoading = false;
bool isLiked = false;
int nLike = 0;
num vote = 0;
num finalVote = 0;
int finalVoteFunction = 0;

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic>? posts;
  List<dynamic> users = [];
  @override
  void initState() {
    super.initState();
    getPosts();
  }

  ListTile buildPostHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(currentUser.photoUrl),
        backgroundColor: Colors.grey,
      ),
      title: GestureDetector(
        onTap: () => print('showing profile'),
        child: Text(
          currentUser.username,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      trailing: IconButton(
        onPressed: () => print('deleting post'),
        icon: Icon(Icons.more_vert),
      ),
    );
  }

  getPosts() async {
    setState(() {
      isLoading = true;
    });
  }

  Future<void> _showMyDialog(String? postId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rate this event!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('On a scale of 1 to 5 how was your experience?'),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.star_rate,
                        color: orangeLightColors,
                      ),
                      onPressed: () {
                        sendStar(postId!, currentUser.id, 1);
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.star_rate,
                        color: orangeLightColors,
                      ),
                      onPressed: () {
                        sendStar(postId!, currentUser.id, 2);
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.star_rate,
                        color: orangeLightColors,
                      ),
                      onPressed: () {
                        sendStar(postId!, currentUser.id, 3);
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.star_rate,
                        color: orangeLightColors,
                      ),
                      onPressed: () {
                        sendStar(postId!, currentUser.id, 4);
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.star_rate,
                        color: orangeLightColors,
                      ),
                      onPressed: () {
                        sendStar(postId!, currentUser.id, 5);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  showComments(
    BuildContext context, {
    String? postId,
    String? ownerId,
    String? mediaUrl,
  }) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Comments(
        postId: postId,
        postOwnerId: ownerId,
        postMediaUrl: mediaUrl,
        photoUrl: currentUser.photoUrl,
      );
    }));
  }

  giveLike() {
    setState(() {
      if (isLiked) {
        isLiked = false;
      } else {
        isLiked = true;
      }
    });
  }

  sendStar(String refPostId, String refUserId, int vote) {
    postStar(refPostId, refUserId, vote);
  }

  Row getStar(int finalVoteFunction) {
    return Row(
      children: <Widget>[
        finalVoteFunction == 2
            ? Row(
                children: <Widget>[
                  Icon(
                    Icons.star_outlined,
                    color: orangeLightColors,
                  ),
                  Icon(
                    Icons.star_outline,
                    color: orangeLightColors,
                  ),
                  Icon(Icons.grade_outlined, color: orangeLightColors),
                  Icon(
                    Icons.grade_outlined,
                    color: orangeLightColors,
                  ),
                  Icon(
                    Icons.grade_outlined,
                    color: orangeLightColors,
                  ),
                ],
              )
            : finalVoteFunction == 3
                ? Row(
                    children: <Widget>[
                      Icon(
                        Icons.star_outlined,
                        color: orangeLightColors,
                      ),
                      Icon(
                        Icons.star_outlined,
                        color: orangeLightColors,
                      ),
                      Icon(Icons.star_outlined, color: orangeLightColors),
                      Icon(
                        Icons.grade_outlined,
                        color: orangeLightColors,
                      ),
                      Icon(
                        Icons.grade_outlined,
                        color: orangeLightColors,
                      ),
                    ],
                  )
                : finalVoteFunction == 4
                    ? Row(
                        children: <Widget>[
                          Icon(
                            Icons.star_outlined,
                            color: orangeLightColors,
                          ),
                          Icon(
                            Icons.star_outlined,
                            color: orangeLightColors,
                          ),
                          Icon(Icons.star_outlined, color: orangeLightColors),
                          Icon(
                            Icons.star_outlined,
                            color: orangeLightColors,
                          ),
                          Icon(
                            Icons.grade_outlined,
                            color: orangeLightColors,
                          ),
                        ],
                      )
                    : finalVoteFunction == 5
                        ? Row(
                            children: <Widget>[
                              Icon(
                                Icons.star_outlined,
                                color: orangeLightColors,
                              ),
                              Icon(
                                Icons.star_outlined,
                                color: orangeLightColors,
                              ),
                              Icon(Icons.star_outlined,
                                  color: orangeLightColors),
                              Icon(
                                Icons.star_outlined,
                                color: orangeLightColors,
                              ),
                              Icon(
                                Icons.star_outlined,
                                color: orangeLightColors,
                              ),
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              Icon(
                                Icons.star_outlined,
                                color: orangeLightColors,
                              ),
                              Icon(
                                Icons.grade_outlined,
                                color: orangeLightColors,
                              ),
                              Icon(Icons.grade_outlined,
                                  color: orangeLightColors),
                              Icon(
                                Icons.grade_outlined,
                                color: orangeLightColors,
                              ),
                              Icon(
                                Icons.grade_outlined,
                                color: orangeLightColors,
                              ),
                            ],
                          ),
      ],
    );
  }

  buildPost() {
    if (isLoading) {
      return circularProgress();
    }

    print(posts!.length);
    return Column(
      children: <Widget>[
        Container(
          height: 700,
          width: double.infinity,
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: Color(0xffEFEFEF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(34))),
          child: Container(
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                String img = posts![index].mediaUrl!;
                int likes = posts![index].likes.length;
                int voteDivider = posts![index].vote.length;
                if (finalVote == 0) {
                  for (int j = 1; j < voteDivider + 1; j++) {
                    vote += posts![index].vote[j.toString()];
                    print(vote.toString());
                  }
                  finalVote = vote / voteDivider;
                }
                finalVoteFunction = finalVote.toInt();
                print(voteDivider.toString());
                nLike += likes;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FutureBuilder(
                      builder: (context, snapshot) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              posts![index].userPhotoUrl,
                            ),
                            backgroundColor: Colors.grey,
                          ),
                          title: GestureDetector(
                            onTap: () => print('showing profile'),
                            child: Text(
                              posts![index].username,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Text(posts![index].location!),
                          trailing: IconButton(
                            onPressed: () =>
                                Comments(postId: posts![index].postId),
                            icon: Icon(Icons.more_vert),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      onDoubleTap: () {
                        updateLikeByPostId(posts![index].postId, likes);
                        giveLike();
                        setState(() {
                          if (isLiked == true) {
                            nLike += 0;
                          } else if (isLiked == false) {
                            nLike -= 2;
                          }
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Image.network(
                            img,
                            scale: 1,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 40.0, left: 20.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                updateLikeByPostId(posts![index].postId, likes);
                                giveLike();
                                setState(() {
                                  if (isLiked == true) {
                                    nLike += 0;
                                  } else if (isLiked == false) {
                                    nLike -= 2;
                                  }
                                });
                              },
                              child: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 28.0,
                                color: Colors.pink,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                            GestureDetector(
                              onTap: () => showComments(
                                context,
                                postId: posts![index].postId,
                                ownerId: posts![index].ownerId,
                                mediaUrl: posts![index].mediaUrl,
                              ),
                              child: Icon(
                                Icons.chat,
                                size: 28.0,
                                color: Colors.blue[900],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                            GestureDetector(
                              onTap: () => _showMyDialog(posts![index].postId),
                              child: Icon(
                                Icons.star,
                                size: 28.0,
                                color: orangeLightColors,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "The event will take place on:" + " ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    posts![index].date!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "The artist will participate:" + " ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    posts![index].artist!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20.0),
                              child: Text(
                                nLike.toString() + " likes",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20.0),
                              child: getStar(finalVoteFunction),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20.0),
                              child: Text(
                                posts![index].username! + " ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(child: Text(posts![index].description!))
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(
        context,
        isAppTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          buildPost(),
        ],
      ),
    );
  }
}
