import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterwebapp/models/user_post.dart';
import 'package:flutterwebapp/network/exception.dart';
import 'package:flutterwebapp/services/api_service.dart';

part 'user_posts_event.dart';

part 'user_posts_state.dart';

class UserPostsBloc extends Bloc<UserPostsEvent, UserPostsState> {
  UserPostsBloc({required this.apiService}) : super(UserPostsStateInitial());

  final ApiService apiService;

  @override
  Stream<UserPostsState> mapEventToState(UserPostsEvent event) async* {
    if (event is LoadUserPostsEvent) {
      yield UserPostsStateLoading();
      try {
        final paginatedPosts = await apiService.fetchUserPosts(event.userId);
        yield UserPostsStateSuccess(paginatedPosts.posts);
      } catch (error) {
        yield error is APIException ? UserPostsStateError(error) : UserPostsStateError(FetchDataException());
      }
    }
  }
}
