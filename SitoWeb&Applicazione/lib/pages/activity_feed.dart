import 'package:flutter/material.dart';
import 'package:testosocial2/database/account.dart';
import 'package:testosocial2/database/method.dart';
import 'package:testosocial2/pages/timeline.dart';
import 'package:testosocial2/utility/color.dart';
import 'package:testosocial2/widget/header.dart';
import 'package:testosocial2/widget/progress.dart';

class ActivityFeed extends StatefulWidget {
  ActivityFeed({Key? key}) : super(key: key);

  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  List<dynamic>? posts;
  List<dynamic> users = [];
  int userCap = 0;
  int maxUser = 0;
  int noComment = 0;

  void initState() {
    super.initState();
  }

  buildSelector() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              primary: userCap == 1 ? Colors.grey[350] : Colors.white,
            ),
            onPressed: () {
              setState(() {
                userCap = 1;
                noComment = 0;
                maxUser = 0;
              });
            },
            child: Text(
              "Post in my ZIP",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              primary: maxUser == 1 ? Colors.grey[350] : Colors.white,
            ),
            onPressed: () {
              setState(() {
                maxUser = 1;
                noComment = 0;
                userCap = 0;
              });
            },
            child: Text(
              "User with max post",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              primary: noComment == 1 ? Colors.grey[350] : Colors.white,
            ),
            onPressed: () {
              setState(() {
                noComment = 1;
                maxUser = 0;
                userCap = 0;
              });
            },
            child: Text(
              "Users with no comments",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
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

  builPostZip() {
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
                                getPostComment(posts![index].postId),
                            icon: Icon(Icons.more_vert),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      onDoubleTap: () {
                        updateLikeByPostId(posts![index].postId, likes);

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

  buildSearchResult() {
    return FutureBuilder(
      future: getUserMaxPost(),
      builder: (context, AsyncSnapshot<Account> snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        String displayName = snapshot.data!.displayName!;
        String username = snapshot.data!.username!;
        String photoUrl = snapshot.data!.photoUrl!;

        return Row(
          children: <Widget>[
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(photoUrl),
            ),
            Text(
              displayName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(username),
          ],
        );
      },
    );
  }

  buildUserNoComment() {
    return FutureBuilder(
      future: getUserByNoComment(),
      builder: (context, AsyncSnapshot<List<Account>> snapshot) {
        if (!snapshot.hasData) {
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
              title: Text(snapshot.data![index].displayName!),
              subtitle: Text(snapshot.data![index].username!),
            );
          },
        );
      },
    );
  }

  buildChose() {
    if (userCap == 1) {
      return builPostZip();
    } else if (maxUser == 1) {
      return buildSearchResult();
    } else if (noComment == 1) {
      return buildUserNoComment();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context,
        isAppTitle: false,
        titleText: "Rule",
      ),
      body: Column(
        children: <Widget>[
          buildSelector(),
          buildChose(),
        ],
      ),
    );
    //buildSelector(),
    //buildPost(),
  }
}
