import 'package:finafinalproject/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              "SignUp",
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
                    FirebaseAuth mySignUpProcess = FirebaseAuth.instance;

                    UserCredential MySignUp =
                        await mySignUpProcess.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                  } catch (e) {
                    print("===========================");
                    print("sorry something wrong ");
                    print("===========================");
                  }
                },
                child: Text("Sign-Up")),
            ElevatedButton(onPressed: () {}, child: Text("Login using Gmail")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return LogIn();
                    },
                  ));
                },
                child: Text("already have account")),
          ],
        ),
      ),
    );
  }
}
