import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finafinalproject/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AddUserInformation() async {
    try {
      CollectionReference db =
          await FirebaseFirestore.instance.collection("students");
      db.add({
        "name": "waed",
        "Family_members": [
          {
            "father and Mother": [
              {"father_name": "mahmoud"},
              {"mother_name": "enas"}
            ]
          },
          {
            "brothers and sisters": [
              {"brother": "khaleel"},
              {"sister": "eman"}
            ]
          },
        ]
      });
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      debugPrint("added");
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    } catch (e) {
      debugPrint("error");
    }
  }

  updateUserInformation() async {
    CollectionReference db =
        await FirebaseFirestore.instance.collection("students");

    db
        .doc("wiS3DL6QCYWhntvaXqny")
        .set({"name": "Fatima"}, SetOptions(merge: true));
  }

  DeleteTheUSer() async {
    CollectionReference db =
        await FirebaseFirestore.instance.collection("students");

    db.doc("FCPFa0PPzRYTAMCwztbA").delete();
  }

  File? myFile;

  var imagePick = ImagePicker();

  uploadImageProcess() async {
    var theImageThatIHavePicked =
        await imagePick.pickImage(source: ImageSource.camera);

    if (imagePick != null) {
      var fileName = basename(theImageThatIHavePicked!.path);
      myFile = File(theImageThatIHavePicked!.path);

      var refrenceforMyStorage =
          FirebaseStorage.instance.ref("myPictures/$fileName");

      await refrenceforMyStorage.putFile(myFile!);

      var TheUrlForTheFileThatIHaveUploaded =
          await refrenceforMyStorage.getDownloadURL().toString();
    } else {
      print("please take a photo using your camera");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 30),
              ),
              Divider(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Please enter your email",
                    filled: true,
                    fillColor: Colors.purple),
                controller: emailController,
              ),
              Divider(
                height: 50,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Please enter your password",
                    filled: true,
                    fillColor: Colors.purple),
                controller: passwordController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      FirebaseAuth myLoginProcess = FirebaseAuth.instance;

                      UserCredential myCred =
                          await myLoginProcess.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);

                      if (myCred.user!.emailVerified == false) {
                        User? mylogged = FirebaseAuth.instance.currentUser;

                        await mylogged!.sendEmailVerification();

                        print(mylogged.uid);
                      }

                      print("successfully log in");
                    } catch (e) {
                      print("===========================");
                      print("sorry something wron ");
                      print("===========================");
                    }
                  },
                  child: Text("Login")),
              ElevatedButton(
                  onPressed: () async {
                    // UserCredential myGoogleCred = await signInWithGoogle();
                  },
                  child: Text("Login using Gmail")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SignUp();
                      },
                    ));
                  },
                  child: Text("you dont have an account")),
              ElevatedButton(
                  onPressed: AddUserInformation,
                  child: Text("add user information")),
              ElevatedButton(
                  onPressed: updateUserInformation,
                  child: Text("update user information ")),
              ElevatedButton(
                  onPressed: DeleteTheUSer,
                  child: Text("delete user information")),
              ElevatedButton(
                  onPressed: uploadImageProcess,
                  child: Text("upload one file")),
            ],
          ),
        ),
      ),
    );
  }
}
