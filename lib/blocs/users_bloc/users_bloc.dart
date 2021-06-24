import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterwebapp/models/users.dart';
import 'package:flutterwebapp/network/exception.dart';
import 'package:flutterwebapp/services/api_service.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({required this.apiService}) : super(UsersStateInitial());
  final ApiService apiService;
  User? _selectedUser;
  double scrollOffset = 0.0;

  User? get selectedUser => _selectedUser;

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is LoadUsersEvent && state is! UsersStateSuccess) {
      yield UsersStateLoading();
      try {
        final paginatedUsers = await apiService.fetchUsers();
        yield UsersStateSuccess(paginatedUsers.users);
      } catch (error) {
        yield error is APIException ? UsersStateError(error) : UsersStateError(FetchDataException());
      }
    } else if (event is SelectUserEvent) {
      _selectedUser = event.user;
      if (state is UsersStateSuccess) {
        final users = (state as UsersStateSuccess).users!;
        final updated = <User>[];
        updated.addAll(users);
        yield UsersStateSuccess(updated);
      }
    }
  }
}
