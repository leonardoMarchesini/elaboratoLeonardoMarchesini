import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testosocial2/database/method.dart';
import 'package:testosocial2/pages/home.dart';
import 'package:testosocial2/widget/progress.dart';
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController artistController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  PickedFile? file;
  bool isUploading = false;
  String postId = Uuid().v4();
  bool classicDance = false;
  bool comedy = false;
  bool sport = false;
  bool neomelodica = false;
  bool pop = false;
  bool rock = false;
  bool mistyCopeland = false;
  bool robertoBenigni = false;
  bool marcoRuben = false;
  bool ninoDangelo = false;
  bool rihanna = false;
  bool robertPlant = false;

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

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text("Create Post"),
          children: <Widget>[
            SimpleDialogOption(
              child: Text(
                "Photo with Camera",
              ),
              onPressed: handleTakePhoto,
            ),
            SimpleDialogOption(
              child: Text(
                "Image from Gallery",
              ),
              onPressed: handleChooseFromGallery,
            ),
            SimpleDialogOption(
              child: Text(
                "Cancel",
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Container buildSplashScreen() {
    return Container(
      color: Colors.teal.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
              elevation: 0.0,
              onPressed: () => selectImage(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                "Upload Image",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
              color: Colors.deepOrange,
            ),
          ),
          Text(
            'Share an Event',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              fontSize: 60.0,
            ),
          ),
          Text(
            'Become Part of a Community',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              fontSize: 30.0,
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/smartsocial-bad2d.appspot.com/o/upload.svg?alt=media&token=116dbea5-15a6-4ad9-9245-6c37ea098a68',
            height: 260.0,
          ),
        ],
      ),
    );
  }

  clearImage() {
    setState(() {
      file = null;
    });
  }

  Future<String> uploadImage(imageFile) async {
    UploadTask uploadTask =
        storageRef.child("post_$postId.jpg").putFile(imageFile);
    TaskSnapshot storageSnap = await uploadTask;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
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
    uploadEvent(postId, captionController.text, locationController.text,
        dataController.text, timestamp, mediaUrl, 0, currentUser.id);
    captionController.clear();
    locationController.clear();
    setState(() {
      file = null;
      isUploading = false;
      postId = Uuid().v4();
    });
  }

  Scaffold buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: clearImage,
        ),
        title: Text(
          "Caption Post",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          FlatButton(
            onPressed: isUploading ? null : handleSubmit,
            child: Text(
              "Post",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          isUploading ? linearProgress() : Text(""),
          Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        File(file!.path),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                currentUser.photoUrl,
              ),
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: captionController,
                decoration: InputDecoration(
                  hintText: "Write the name of the event...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.album_outlined,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 40.0,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          primary:
                              mistyCopeland ? Colors.grey[350] : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            mistyCopeland = true;
                          });
                        },
                        child: Text(
                          "MISTY COPELAND",
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
                          primary:
                              robertoBenigni ? Colors.grey[350] : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            robertoBenigni = true;
                          });
                        },
                        child: Text(
                          "ROBERTO BENIGNI",
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
                          primary: marcoRuben ? Colors.grey[350] : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            marcoRuben = true;
                          });
                        },
                        child: Text(
                          "MARCO RUBEN",
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
                          primary:
                              ninoDangelo ? Colors.grey[350] : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            ninoDangelo = true;
                          });
                        },
                        child: Text(
                          "NINO D'ANGELO",
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
                          primary: rihanna ? Colors.grey[350] : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            rihanna = true;
                          });
                        },
                        child: Text(
                          "RIHANNA",
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
                          primary:
                              robertPlant ? Colors.grey[350] : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            robertPlant = true;
                          });
                        },
                        child: Text(
                          "ROBERT PLANT",
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.pin_drop,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: "Where will this event take place?",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.event_outlined,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250,
              child: TextField(
                controller: dataController,
                decoration: InputDecoration(
                  hintText: "When will this event take place?",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 40.0,
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: classicDance ? Colors.grey[350] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          classicDance = true;
                        });
                      },
                      child: Text(
                        "Classic Dance",
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
                        primary: comedy ? Colors.grey[350] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          comedy = true;
                        });
                      },
                      child: Text(
                        "Comedy",
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
                        primary: sport ? Colors.grey[350] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          sport = true;
                        });
                      },
                      child: Text(
                        "Sport",
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
                        primary: neomelodica ? Colors.grey[350] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          neomelodica = true;
                        });
                      },
                      child: Text(
                        "Neomelodica",
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
                        primary: pop ? Colors.grey[350] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          pop = true;
                        });
                      },
                      child: Text(
                        "Pop",
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
                        primary: rock ? Colors.grey[350] : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          rock = true;
                        });
                      },
                      child: Text(
                        "Rock",
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? buildSplashScreen() : buildUploadForm();
  }
}
