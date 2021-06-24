import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterwebapp/models/user_profile.dart';
import 'package:flutterwebapp/network/exception.dart';
import 'package:flutterwebapp/services/api_service.dart';
import 'package:meta/meta.dart';

part 'user_profile_event.dart';

part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({required this.apiService}) : super(UserProfileStateInitial());

  final ApiService apiService;

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is LoadUserProfileEvent) {
      yield UserProfileStateLoading();
      try {
        final userProfile = await apiService.fetchUserProfile(event.userId);
        yield UserProfileStateSuccess(userProfile);
      } catch (error) {
        yield error is APIException ? UserProfileStateError(error) : UserProfileStateError(FetchDataException());
      }
    }
  }
}
