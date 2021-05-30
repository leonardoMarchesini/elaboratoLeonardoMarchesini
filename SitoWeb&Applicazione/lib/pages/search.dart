import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testosocial2/models/user.dart';
import 'package:testosocial2/pages/home.dart';
import 'package:testosocial2/widget/progress.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot>? searchResultsFuture;

  handleSearch(String query) {
    Future<QuerySnapshot> users =
        usersRef.where("displayName", isGreaterThanOrEqualTo: query).get();
    setState(() {
      searchResultsFuture = users;
    });
  }

  clearSearch() {
    searchController.clear();
  }

  PreferredSize buildSearchField() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: "Search for a user...",
              filled: true,
              fillColor: Colors.grey[300],
              prefixIcon: Icon(
                Icons.search,
                size: 28.0,
              ),
              suffixIcon: IconButton(
                onPressed: clearSearch(),
                icon: Icon(Icons.clear),
              ),
            ),
            onFieldSubmitted: handleSearch,
          ),
        ),
      ),
    );
  }

  Column buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            color: Colors.white,
          ),
          height: 20,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/smartsocial-bad2d.appspot.com/o/search.svg?alt=media&token=66a18175-4487-4a18-a439-ca91637320a6',
                    height: orientation == Orientation.portrait ? 300.0 : 200.0,
                  ),
                  Text(
                    "Find Users",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      fontSize: 60.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildSearchResult() {
    return FutureBuilder<QuerySnapshot>(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> searchResults = [];
        snapshot.data!.docs.forEach((doc) {
          User user = User.fromDocument(doc);
          UserResult searchResult = UserResult(user);
          searchResults.add(searchResult);
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: buildSearchField(),
      body:
          searchResultsFuture == null ? buildNoContent() : buildSearchResult(),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;

  UserResult(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple.withOpacity(0.7),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: null,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(user.photoUrl),
              ),
              title: Text(
                user.displayName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                user.username,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Divider(
            height: 2.0,
            color: Colors.white54,
          ),
        ],
      ),
    );
  }
}
