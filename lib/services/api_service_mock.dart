import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutterwebapp/models/user_post.dart';
import 'package:flutterwebapp/models/user_profile.dart';
import 'package:flutterwebapp/models/users.dart';
import 'package:flutterwebapp/services/api_service.dart';
import 'package:flutterwebapp/theme/assets.dart';

class ApiServiceMock extends ApiService {
  @override
  Future<PaginatedUsers> fetchUsers() async {
    return PaginatedUsers.fromJson(await _loadJson(Assets.dummyUsersResponse));
  }

  @override
  Future<UserProfile> fetchUserProfile(String? userId) async {
    assert(userId != null && userId.isNotEmpty);
    return UserProfile.fromJson(await _loadJson(Assets.dummyUserProfileResponse));
  }

  @override
  Future<PaginatedPosts> fetchUserPosts(String userId) async {
    assert(userId.isNotEmpty);
    return PaginatedPosts.fromJson(await _loadJson(Assets.dummyUserPostsResponse));
  }

  Future<dynamic> _loadJson(String asset) async {
    return jsonDecode(await rootBundle.loadString(asset));
  }
}
