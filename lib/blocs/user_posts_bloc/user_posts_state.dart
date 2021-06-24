part of 'user_posts_bloc.dart';

abstract class UserPostsState extends Equatable {
  const UserPostsState();
}

class UserPostsStateInitial extends UserPostsState {
  @override
  List<Object> get props => [];
}

class UserPostsStateLoading extends UserPostsState {
  @override
  List<Object> get props => [];
}

class UserPostsStateSuccess extends UserPostsState {
  const UserPostsStateSuccess(this.posts);

  final List<Post>? posts;

  @override
  List<Object?> get props => [posts];
}

class UserPostsStateError extends UserPostsState {
  const UserPostsStateError(this.apiException);

  final APIException apiException;

  @override
  List<Object> get props => [apiException];
}
