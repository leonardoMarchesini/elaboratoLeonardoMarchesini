import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:testosocial2/database/interest.dart';
import 'package:testosocial2/pages/comments.dart';
import 'package:testosocial2/pages/edit_profile.dart';
import 'package:testosocial2/pages/home.dart';
import 'package:testosocial2/widget/post.dart';
import 'package:testosocial2/widget/progress.dart';
import '../database/account.dart';
import '../database/method.dart';
import 'home.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLiked = true;
  String postOrientation = "grid";
  bool isLoading = false;
  int postCount = 0;
  List<Post> posts = [];
  List<String> categories = ["All Event", "Expired Posts", "Upcoming Events"];

  void initState() {
    getProfilePosts();
    buildProfilePost();
    super.initState();
  }

  getProfilePosts() {
    return FutureBuilder(
      future: getProfilePosts(),
      builder: (context, AsyncSnapshot<List<Post>> snapshot){
        if(!snapshot.hasData) {
          return circularProgress();
        }
        return ListView.builder(itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(snapshot.data![index].userPhotoUrl!),
            ),
            title: Image.network(snapshot.data![index].mediaUrl!),
            subtitle: Row(
              children: <Widget>[
                Text(snapshot.data![index].username! + snapshot.data![index].description!),
                Text(snapshot.data![index].likes),
                Text(snapshot.data![index].vote.values),
                Text(snapshot.data![index].artist!),
              ],
            ),
          );
        },
        );
      },);
  }

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfile(),
      ),
    );
  }

  Container buildButton({
    String? text,
    Function? function,
  }) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: FlatButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfile(),
            )),
        child: Container(
          width: 250.0,
          height: 27.0,
          child: Text(
            text!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  buildProfileButton() {
    bool isProfileOwner = currentUser.id == currentUser.id;
    if (isProfileOwner) {
      return buildButton(text: "Edit Profile", function: editProfile);
    }
  }

  buildProfileHeader() {
    return FutureBuilder(
      future: getUser(currentUser.email),
      builder: (context, AsyncSnapshot<Account> snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        String? name = snapshot.data?.displayName;
        print(name);
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 7),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(currentUser.photoUrl),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 38.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        snapshot.data!.username!,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        snapshot.data!.bio!,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 17,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                snapshot.data!.cap!,
                                style: TextStyle(
                                  color: Colors.white,
                                  wordSpacing: 2,
                                  letterSpacing: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 58.0, left: 38.0, top: 15.0, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        snapshot.data!.countPost!.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'post count',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    width: 0.2,
                    height: 22,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'follower',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    width: 0.2,
                    height: 22,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'following',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  buildInterest() {
    return FutureBuilder(
      future: getInterest(currentUser.email),
      builder: (context, AsyncSnapshot<Interest> snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<String> interest = [];
        String cD = snapshot.data!.classicDance!;
        String c = snapshot.data!.comedy!;
        String mD = snapshot.data!.sport!;
        String n = snapshot.data!.neomelodica!;
        String p = snapshot.data!.pop!;
        String r = snapshot.data!.rock!;

        if (cD == "1") {
          interest.add("Classic Dance");
        }
        if (c == "1") {
          interest.add("Comedy");
        }
        if (mD == "1") {
          interest.add("Sport");
        }
        if (n == "1") {
          interest.add("Neomelodica");
        }
        if (p == "1") {
          interest.add("Pop");
        }
        if (r == "1") {
          interest.add("Rock");
        }

        return Container(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: interest.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33),
                    border: Border.all(color: Colors.white12),
                  ),
                  margin: EdgeInsets.only(right: 13),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 13.0, bottom: 5, right: 20, left: 20),
                    child: Text(
                      interest[index],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  buildTogglePostOrientation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.grid_view),
          color: postOrientation == "grid" ? Colors.white : Colors.grey,
          onPressed: () => setPostOrientation("grid"),
        ),
        IconButton(
          icon: Icon(Icons.list),
          color: postOrientation == "list" ? Colors.white : Colors.grey,
          onPressed: () => setPostOrientation("list"),
        ),
      ],
    );
  }

  setPostOrientation(String postOrientation) {
    setState(() {
      this.postOrientation = postOrientation;
    });
  }

  handleLikePost() {
    int likesCount = 1;
    if (isLiked == true) {
      likesCount--;
      isLiked = false;
    } else {
      likesCount++;
      isLiked = true;
    }
  }

  buildProfilePost() {
    if (isLoading) {
      return circularProgress();
    } else if (postOrientation == "grid") {
      return Center(
        child: Container(
          height: 700,
          width: double.infinity,
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: Color(0xffEFEFEF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(34))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 33.0, right: 25.0, left: 25.0),
                child: Text(
                  'Posts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 33,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 25, left: 25),
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 17.0, top: 3),
                      child: index == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  categories[index],
                                  style: TextStyle(
                                    color: Color(0xff434AE8),
                                    fontSize: 19,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 2,
                                  backgroundColor: Color(0xff434AE8),
                                )
                              ],
                            )
                          : Text(
                              categories[index],
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.9),
                                fontSize: 19,
                              ),
                            ),
                    );
                  },
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.only(right: 25, left: 25),
                      height: 500,
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          String img = posts[index].mediaUrl!;
                          return Container(
                            child: FutureBuilder(builder: (context, snapshot) {
                              return ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                child: Image.network(
                                  img,
                                  scale: 1,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.count(2, index.isEven ? 3 : 1),
                        mainAxisSpacing: 9,
                        crossAxisSpacing: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (postOrientation == "list") {
      return Center(
        child: Container(
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
              itemCount: posts.length,
              itemBuilder: (context, index) {
                String img = posts[index].mediaUrl!;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FutureBuilder(
                      builder: (context, snapshot) {
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
                          subtitle: Text(posts[index].location!),
                          trailing: IconButton(
                            onPressed: () => print('deleting post'),
                            icon: Icon(Icons.more_vert),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      onDoubleTap: () => print('liking post'),
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
                              onTap: () =>
                                  isLiked ? isLiked = false : isLiked = true,
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
                                postId: posts[index].postId,
                                ownerId: posts[index].ownerId,
                                mediaUrl: posts[index].mediaUrl,
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
                              onTap: () => _showMyDialog(posts[index].postId),
                              child: Icon(
                                Icons.star,
                                size: 28.0,
                                color: Colors.yellow[900],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20.0),
                              child: Text(
                                "${posts[index].likes.length} likes",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20.0),
                              child: Text(
                                posts[index].username! + " ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(child: Text(posts[index].description!))
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
      );
    }
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
      );
    }));
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
                      icon: Icon(Icons.star_rate),
                      onPressed: () => print(1),
                    ),
                    IconButton(
                      icon: Icon(Icons.star_rate),
                      onPressed: () => print(2),
                    ),
                    IconButton(
                      icon: Icon(Icons.star_rate),
                      onPressed: () => print(3),
                    ),
                    IconButton(
                      icon: Icon(Icons.star_rate),
                      onPressed: () => print(4),
                    ),
                    IconButton(
                      icon: Icon(Icons.star_rate),
                      onPressed: () => print(5),
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

  buildPostHeader() {
    FutureBuilder(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.more_vert),
              color: Colors.white,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(),
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          buildProfileHeader(),
          buildInterest(),
          buildTogglePostOrientation(),
          buildProfilePost(),
        ],
      ),
    );
  }
}
