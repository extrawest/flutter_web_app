import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterwebapp/screens/user_posts_screen.dart';
import 'package:flutterwebapp/screens/user_profile_screen.dart';
import 'package:flutterwebapp/screens/users_screen.dart';
import 'package:flutterwebapp/screens/wrong_address_screen.dart';

class Routes {
  static const root = '/';
  static const home = '/home';
  static const _userDetails = '/user/:userId';
  static const _userPosts = '/user/:userId/posts';

  static String userDetails(String? userId) => 'user/$userId';

  static String userPosts(String userId) => 'user/$userId/posts';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const WrongAddressScreen();
    });
    router.define(root, handler: _usersHandler);
    router.define(home, handler: _usersHandler);
    router.define(_userDetails, handler: _userDetailsHandler);
    // router.define(_userDetails, handler: _userDetailsHandler, transitionDuration: Duration(seconds: 1));
    router.define(_userPosts, handler: _userPostsHandler);
  }
}

var _usersHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const UsersScreen();
});

var _userDetailsHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return UserProfileScreen(userId: params['userId']![0]);
});

var _userPostsHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return UserPostsScreen(userId: params['userId']![0]);
});
