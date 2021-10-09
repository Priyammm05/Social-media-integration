import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/user_model.dart';

import 'package:flutter_firebase_app/widgets/clipper.dart';
import 'package:flutter_firebase_app/widgets/post_carousal.dart';

class Profile extends StatefulWidget {
  final User user;
  Profile({@required this.user});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PageController _yourPostsPageController;
  PageController _favouritesPageController;


  @override
  void initState() {
    super.initState();

    _yourPostsPageController =
        PageController(initialPage: 0, viewportFraction: 0.8);
    _favouritesPageController =
        PageController(initialPage: 0, viewportFraction: 0.8);
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
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: AssetImage("images/user_background.jpg"),
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
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                widget.user.name,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Following",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      widget.user.following.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Followers",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      widget.user.followers.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            PostsCarousel(
              pageController: _yourPostsPageController,
              title: "Your Posts",
              posts: widget.user.posts,
            ),
            PostsCarousel(
              pageController: _favouritesPageController,
              title: "Fvaourites",
              posts: widget.user.favorites,
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
