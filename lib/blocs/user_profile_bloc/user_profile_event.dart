part of 'user_profile_bloc.dart';

@immutable
abstract class UserProfileEvent extends Equatable {}

class LoadUserProfileEvent extends UserProfileEvent {
  LoadUserProfileEvent(this.userId);

  final String? userId;

  @override
  List<Object?> get props => [userId];
}
