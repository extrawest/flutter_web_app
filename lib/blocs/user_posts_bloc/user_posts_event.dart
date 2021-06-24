part of 'user_posts_bloc.dart';

abstract class UserPostsEvent extends Equatable {
  const UserPostsEvent();
}

class LoadUserPostsEvent extends UserPostsEvent {
  const LoadUserPostsEvent(this.userId);

  final String userId;

  @override
  List<Object> get props => [userId];
}
