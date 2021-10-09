import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/data/data.dart';
import 'package:flutter_firebase_app/widgets/post_carousal.dart';
import 'package:flutter_firebase_app/widgets/user_follower.dart';

class Dashboard extends StatefulWidget {
  final String route = "home_screen";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          "SOCIALUP",
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 10,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 3.0,
          labelColor: Theme.of(context).primaryColor,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 18,
          ),
          tabs: [
            Tab(text: "Trending"),
            Tab(text: "Latest"),
          ],
        ),
      ),
      body: ListView(
        children: [
          UserFollowing(),
          SizedBox(height: 15),
          PostsCarousel(
            pageController: _pageController,
            title: "Posts",
            posts: posts,
          ),
        ],
      ),
    );
  }
}
