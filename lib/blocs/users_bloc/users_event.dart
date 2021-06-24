part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class LoadUsersEvent extends UsersEvent {
  @override
  List<Object> get props => [];
}

class SelectUserEvent extends UsersEvent {
  final User user;

  const SelectUserEvent(this.user);

  @override
  List<Object?> get props => [user.id];
}
