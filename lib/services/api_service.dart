import 'package:flutterwebapp/models/user_post.dart';
import 'package:flutterwebapp/models/user_profile.dart';
import 'package:flutterwebapp/models/users.dart';

abstract class ApiService {
  Future<PaginatedUsers> fetchUsers();

  Future<UserProfile> fetchUserProfile(String? userId);

  Future<PaginatedPosts> fetchUserPosts(String userId);
}
