import 'package:flutterwebapp/models/user_post.dart';
import 'package:flutterwebapp/models/user_profile.dart';
import 'package:flutterwebapp/models/users.dart';
import 'package:flutterwebapp/network/api_client.dart';
import 'package:flutterwebapp/services/api_service.dart';

class ApiServiceImpl extends ApiService {
  late ApiClient _apiClient;

  static String _users({int limit = 10}) => '/user?limit=$limit';

  static String _userProfile({required String? userId}) => '/user/$userId';

  static String _userPosts({required String userId, int limit = 10}) => '/user/$userId/post?, limit=$limit';

  ApiServiceImpl(String baseApiUrl, String appId) {
    _apiClient = ApiClient(baseApiUrl: baseApiUrl, appId: appId);
  }

  @override
  Future<PaginatedUsers> fetchUsers() async {
    try {
      final res = await _apiClient.get(_users());
      return PaginatedUsers.fromJson(res);
    } catch (e) {
      print('fetchPostsData error: $e');
      rethrow;
    }
  }

  @override
  Future<UserProfile> fetchUserProfile(String? userId) async {
    assert(userId != null && userId.isNotEmpty);
    try {
      final res = await _apiClient.get(_userProfile(userId: userId));
      return UserProfile.fromJson(res);
    } catch (e) {
      print('fetchPostsData error: $e');
      rethrow;
    }
  }

  @override
  Future<PaginatedPosts> fetchUserPosts(String userId) async {
    assert(userId.isNotEmpty);
    try {
      final res = await _apiClient.get(_userPosts(userId: userId));
      return PaginatedPosts.fromJson(res);
    } catch (e) {
      print('fetchPostsData error: $e');
      rethrow;
    }
  }
}
