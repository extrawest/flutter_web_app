part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();
}

class UserProfileStateInitial extends UserProfileState {
  @override
  List<Object> get props => [];
}

class UserProfileStateLoading extends UserProfileState {
  @override
  List<Object> get props => [];
}

class UserProfileStateSuccess extends UserProfileState {
  const UserProfileStateSuccess(this.userProfile);

  final UserProfile userProfile;

  @override
  List<Object> get props => [userProfile];
}

class UserProfileStateError extends UserProfileState {
  final APIException apiException;

  const UserProfileStateError(this.apiException);

  @override
  List<Object> get props => [apiException];
}
