part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersStateInitial extends UsersState {
  @override
  List<Object> get props => [];
}

class UsersStateLoading extends UsersState {
  @override
  List<Object> get props => [];
}

class UsersStateSuccess extends UsersState {
  final List<User>? users;

  const UsersStateSuccess(this.users);
  @override
  List<Object?> get props => [users];
}

class UsersStateError extends UsersState {
  final APIException apiException;

  const UsersStateError(this.apiException);
  @override
  List<Object> get props => [apiException];
}
