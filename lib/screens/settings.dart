import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/login_screen.dart';
import 'package:flutter_firebase_app/user/change_password.dart';
import 'package:flutter_firebase_app/user/verify_email.dart';
import 'package:flutter_firebase_app/widgets/clipper.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _buildTile(Icon icon, String title, Function onTap) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      onTap: onTap as VoidCallback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: Clipper(),
                  child: Image(
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: AssetImage('images/set_img.png'),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image(
                        height: 130,
                        width: 130,
                        fit: BoxFit.cover,
                        image: AssetImage('images/user.jpg'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  _buildTile(Icon(Icons.notifications), "Notification", () {}),
                  Divider(),
                  _buildTile(Icon(Icons.verified_user_rounded), "Verify Email",
                      () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Verify()));
                  }),
                  Divider(),
                  _buildTile(Icon(Icons.lock_sharp), "Change Password", () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangePassword()));
                  }),
                  Divider(),
                  _buildTile(Icon(Icons.account_circle), "Account", () {}),
                  Divider(),
                  _buildTile(Icon(Icons.help), "Help", () {}),
                  Divider(),
                  _buildTile(Icon(Icons.error), "About", () {}),
                  Divider(),
                  _buildTile(
                    Icon(Icons.cancel),
                    "Logout",
                    () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                  ),
                  SizedBox(height: 30),
                  ListTile(
                    leading: Icon(Icons.add, color: Colors.blue),
                    title: Text(
                      "Add Account",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
