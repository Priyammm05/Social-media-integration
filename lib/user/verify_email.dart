import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/login_screen.dart';
import 'package:flutter_firebase_app/widgets/clipper.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final uid = FirebaseAuth.instance.currentUser.uid;
  final email = FirebaseAuth.instance.currentUser.email;
  final creationTime = FirebaseAuth.instance.currentUser.metadata.creationTime;

  User user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.amber,
          content: Text(
            "Verification email has been sent",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: ClipPath(
                clipper: Clipper(),
                child: Image(
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage("images/profile.png"),
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  "User ID : ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 6),
                Text(
                  uid,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email : $email",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
                user.emailVerified
                    ? Text(
                        "Verified",
                        style: TextStyle(fontSize: 22, color: Colors.lightBlue),
                      )
                    : TextButton(
                        onPressed: () => verifyEmail(),
                        child: Text(
                          "Verify Email",
                          style:
                              TextStyle(fontSize: 22, color: Colors.lightBlue),
                        ),
                      ),
              ],
            ),
            SizedBox(height: 30),
            Column(
              children: [
                Text(
                  "Created At : ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 6),
                Text(
                  creationTime.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
