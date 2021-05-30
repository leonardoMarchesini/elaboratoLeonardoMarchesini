import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:testosocial2/database/account.dart';
import 'package:testosocial2/database/interest.dart';
import 'package:testosocial2/database/post.dart';
import 'package:testosocial2/database/comment.dart';
import 'account.dart';

Future<List<Account>> fetchAccount() async {
  var response = await http.get(Uri.http('10.0.2.2:3000', '/account'));
  var responseAccount = json.decode(response.body) as List;
  if (response.statusCode == 200) {
    responseAccount.map((e) => Account.fromJson(e)).toList().forEach((element) {
      print(element.email!);
    });
    return responseAccount.map((e) => Account.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load');
  }
}

Future<int?> getUserId(String email) async {
  var response = await http.get(Uri.http('localhost:3000', '/account/$email'));
  var responseAccount = json.decode(response.body) as List;
  print(response.statusCode);
  if (response.statusCode == 200) {
    responseAccount.map((e) => Account.fromJson(e)).toList().forEach((element) {
      if (element.email == email) {
        print(element.id);
        return print(element.id);
      } else {}
    });
  } else {
    throw Exception('Failed to load');
  }
  throw Exception('idk');
}

Future<List<Account>> getCurrentAccount(String id) async {
  var response = await http.get(Uri.http('10.0.2.2:3000', '/account/$id'));
  var responseAccount = json.decode(response.body) as List;
  print(response.statusCode);
  if (response.statusCode == 200) {
    responseAccount.map((e) => Account.fromJson(e)).toList().forEach((element) {
      print(element.email);
    });
    return responseAccount.map((e) => Account.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load');
  }
}

handleSignIn(GoogleSignInAccount? account) {
  if (account != null) {
    createUserInFirestore();
    print('Accesso effettuato correttamente!: $account');
    setState(() {
      isAuth = true;
    });
  } else {
    setState(() {
      isAuth = false;
    });
  }
}

createUserInFirestore() async {
  final GoogleSignInAccount? user = googleSignIn.currentUser;
  DocumentSnapshot doc = await usersRef.doc(user!.id).get();

  if (!doc.exists) {
    final username = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateAccount(),
      ),
    );
    usersRef.doc(user.id).set({
      "id": user.id,
      "username": username,
      "photoUrl": user.photoUrl,
      "email": user.email,
      "displayName": user.displayName,
      "bio": "",
      "timestamp": timestamp,
    });
    doc = await usersRef.doc(user.id).get();
  }
  currentUser = User.fromDocument(doc);
  print(currentUser);
  print(currentUser.username);
}

makePostRequest(
  String id,
  String email,
  String username,
  String photoUrl,
  String bio,
  String displayName,
  String countComment,
  String countPost,
  String cap,
) async {
  final url = Uri.parse('http://localhost:3000/account');
  Map<String, String> headers = {"Content-type": "application/json"};
  String json =
      '{"id":"$id", "email": "$email", "username": "$username", "photoUrl": "$photoUrl", "bio": "$bio", "displayName": "$displayName", "countComment": "$countComment", "countPost": "$countPost", "cap": "$cap", "getNewsLetter": "1"}';
  Response response = await post(url, headers: headers, body: json);
  int statusCode = response.statusCode;
  String body = response.body;
  print(statusCode);
}

makePostRequestInterest(
  int refId,
  int classicDance,
  int comedy,
  int sport,
  int neomelodica,
  int pop,
  int rock,
) async {
  final url = Uri.parse('http://localhost:3000/interest');
  Map<String, String> headers = {"Content-type": "application/json"};
  String json =
      '{"refId": "$refId", "classicDance": "$classicDance", "comedy": "$comedy", "sport": "$sport", "neomelodica": "$neomelodica", "pop": "$pop", "rock": "$rock"}';
  Response response = await post(url, headers: headers, body: json);
  int statusCode = response.statusCode;
  String body = response.body;
  print(statusCode);
}

handleTakePhoto() async {
  Navigator.pop(context);
  PickedFile? file = await ImagePicker.platform.pickImage(
    source: ImageSource.camera,
    maxHeight: 675,
    maxWidth: 960,
  );
  setState(() {
    this.file = file;
  });
}

handleChooseFromGallery() async {
  Navigator.pop(context);
  PickedFile? file = await ImagePicker.platform.pickImage(
    source: ImageSource.gallery,
  );
  setState(() {
    this.file = file;
  });
}

handleSubmit() async {
  setState(() {
    isUploading = true;
  });
  await compressImage();
  String mediaUrl = await uploadImage(file);
  createPostInFirestore(
    mediaUrl: mediaUrl,
    location: locationController.text,
    description: captionController.text,
  );
  captionController.clear();
  locationController.clear();
  setState(() {
    file = null;
    isUploading = false;
    postId = Uuid().v4();
  });
}

createPostInFirestore(
    {String? mediaUrl, String? location, String? description}) {
  postsRef.doc(currentUser.id).collection("userPosts").doc(postId).set({
    "postId": postId,
    "ownerId": currentUser.id,
    "username": currentUser.username,
    "mediaUrl": mediaUrl,
    "description": description,
    "location": location,
    "timestamp": timestamp,
    "likes": {},
  });
}

compressImage() async {
  final tempDire = await getTemporaryDirectory();
  final path = tempDire.path;
  Im.Image? imageFile = Im.decodeImage(File(file!.path).readAsBytesSync());
  final compressedImageFile = File('$path/img_$postId.jpg')
    ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
  setState(() {
    file = compressedImageFile as PickedFile?;
  });
}

Future<String> uploadImage(imageFile) async {
  UploadTask uploadTask =
      storageRef.child("post_$postId.jpg").putFile(imageFile);
  TaskSnapshot storageSnap = await uploadTask;
  String downloadUrl = await storageSnap.ref.getDownloadURL();
  return downloadUrl;
}

uploadEvent(
  String postId,
  String title,
  String cap,
  String date,
  Timestamp timestamp,
  String mediaUrl,
  int like,
  String ownerId,
) async {
  final url = Uri.parse('http://localhost:3000/post');
  Map<String, String> headers = {"Content-type": "application/json"};
  String json =
      '{"postId": "$postId", "title": "$title", "cap": "$cap", "date": "$date", "timestamp": "$timestamp", "mediaUrl": "$mediaUrl", "like": "$like", "ownerId": "$ownerId"}';
  Response response = await post(url, headers: headers, body: json);
  int statusCode = response.statusCode;
  String body = response.body;
  print(statusCode);
}

Future<List<Post>> getAllPost() async {
  final url = Uri.parse('http://localhost:3000/post');
  Map<String, String> headers = {"Content-type": "application/json"};
  Response response = await get(url, headers: headers);
  var responsePost = json.decode(response.body);
  if (response.statusCode == 200) {
    responsePost.map((e) => Post.fromJson(e)).toList().forEach((element) {
      print(element.title);
    });
    return responsePost.map((e) => Post.fromJson(e)).toList();
  } else
    throw Exception('Failed to load');
}

updateLikeByPostId(String postId, int oldLike) async {
  final url = Uri.parse('http://localhost:3000/post/$postId');
  Map<String, String> headers = {"Content-type": "application/json"};
  int newLike = oldLike++;
  String json = '{"likes": "$newLike"}';
  Response response = await post(url, headers: headers, body: json);
  int statusCode = response.statusCode;
  print(statusCode);
}

postComment(String codMittente, String text, String refPostId) async {
  final url = Uri.parse('http://localhost:3000/comment');
  Map<String, String> headers = {"Content-type": "application/json"};
  String json =
      '{"codMittente": "$codMittente", "text": "$text", "refPostId": "$refPostId"}';
  Response response = await post(url, headers: headers, body: json);
  int statusCode = response.statusCode;
  String body = response.body;
  print(statusCode);
}

postStar(String refPostId, String refUserId, int vote) async {
  final url = Uri.parse('http://localhost:3000/vote');
  Map<String, String> headers = {"Content-type": "application/json"};
  String json =
      '{"refPostId": "$refPostId", "refUserId": "$refUserId", "vote": "$vote"}';
  Response response = await post(url, headers: headers, body: json);
  int statusCode = response.statusCode;
  String body = response.body;
  print(statusCode);
}

Future<CommentDB> getPostComment(String refPostId) async {
  final url = Uri.parse('http://localhost:3000/comment/$refPostId');
  Map<String, String> headers = {"Content-type": "application/json"};
  Response response = await get(url, headers: headers);
  Map<String, dynamic> data = json.decode(response.body);
  print(response.statusCode);
  CommentDB p = CommentDB.fromJson(data);
  print(p);
  return p;
}

Future<List<Account>> getUserByNoComment() async {
  final url = Uri.parse('http://localhost:3000//account/comment');
  Map<String, String> headers = {"Content-type": "application/json"};
  Response response = await get(url, headers: headers);
  var responsePost = json.decode(response.body);
  if (response.statusCode == 200) {
    responsePost.map((e) => Account.fromJson(e)).toList().forEach((element) {
      print(element.title);
    });
    return responsePost.map((e) => Account.fromJson(e)).toList();
  } else
    throw Exception('Failed to load');
}

Future<Account> getUserMaxPost() async {
  final url = Uri.parse('http://localhost:3000/account/maxpost');
  Map<String, String> headers = {"Content-type": "application/json"};
  Response response = await get(url, headers: headers);
  Map<String, dynamic> data = json.decode(response.body);
  Account a = Account.fromJson(data);
  print(response.statusCode);
  return a;
}

Future<List<Post>> getPostByCap(String cap) async {
  final url = Uri.parse('http://localhost:3000/post/$cap');
  Map<String, String> headers = {"Content-type": "application/json"};
  Response response = await get(url, headers: headers);
  var responsePost = json.decode(response.body);
  print(responsePost.runtimeType);
  if (response.statusCode == 200) {
    responsePost.map((e) => Post.fromJson(e)).toList().forEach((element) {
      print(element.title);
    });
    return responsePost.map((e) => Post.fromJson(e)).toList();
  } else
    throw Exception('Failed to load');
}

Future<Account> getUser(String email) async {
  final url = Uri.parse('http://localhost:3000/account/$email');
  Map<String, String> headers = {"Content-type": "application/json"};
  Response response = await get(url, headers: headers);
  Map<String, dynamic> data = json.decode(response.body);
  Account a = Account.fromJson(data);
  print(a.displayName);
  print(response.statusCode);
  return a;
}

Future<Interest> getInterest(String email) async {
  final url = Uri.parse('http://localhost:3000/interest/$email');
  Map<String, String> headers = {"Content-type": "application/json"};
  Response response = await get(url, headers: headers);
  Map<String, dynamic> data = json.decode(response.body);
  Interest i = Interest.fromJson(data);
  print(i.refId);
  print(response.statusCode);
  return i;
}

Future<List<Post>> getPostById(String email) async {
  final url = Uri.parse('http://localhost:3000/post/$email');
  Map<String, String> headers = {"Content-type": "application/json"};
  Response response = await get(url, headers: headers);
  var responsePost = json.decode(response.body);
  print(responsePost.runtimeType);
  if (response.statusCode == 200) {
    responsePost.map((e) => Post.fromJson(e)).toList().forEach((element) {
      print(element.title);
    });
    return responsePost.map((e) => Post.fromJson(e)).toList();
  } else
    throw Exception('Failed to load');
}

changeInfo(
  String id,
  String email,
  String username,
  String photoUrl,
  String bio,
  String displayName,
  String cap,
  String getNewsLetter,
) async {
  final url = Uri.parse('http://localhost:3000/account');
  Map<String, String> headers = {"Content-type": "application/json"};
  String json =
      '{"id":"$id", "email": "$email", "username": "$username", "photoUrl": "$photoUrl", "bio": "$bio", "displayName": "$displayName", "cap": "$cap", "getNewsLetter": "$getNewsLetter"}';
  Response response = await put(url, headers: headers, body: json);
  int statusCode = response.statusCode;
  String body = response.body;
  print(statusCode);
}

Future<dynamic> getUserIdo(String email) async {
  final url = Uri.parse('http://localhost:3000/account/$email');
  Map<String, String> headers = {"Content-type": "application/json"};
  Response response = await get(url, headers: headers);
  Map<String, dynamic> data = json.decode(response.body);
  print(response.statusCode);
  print(response.body);
  print(data.values.toString());
  return data.values.toString();
}
