import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwebapp/blocs/users_bloc/users_bloc.dart';
import 'package:flutterwebapp/models/users.dart';
import 'package:flutterwebapp/routes.dart';
import 'package:flutterwebapp/widgets/network_image_wrapper.dart';

import '../main.dart';
import 'api_exception_widget.dart';
import 'centered_progress_indicator.dart';

class UserList extends StatefulWidget {
  final bool useWideLayout;

  const UserList({Key? key, required this.useWideLayout}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late UsersBloc _usersBloc;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _usersBloc = BlocProvider.of(context);
    _usersBloc.add(LoadUsersEvent());
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      _usersBloc.scrollOffset = _scrollController!.offset;
    });
  }

  void onUserTap(User user, BuildContext context) {
    _usersBloc.add(SelectUserEvent(user));
    // Navigator.of(context).pushNamed(Routes.userDetails(user.id));
    router?.navigateTo(
      context,
      Routes.userDetails(user.id),
      transitionDuration: const Duration(seconds: 1),
      transition: TransitionType.custom,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
            position: Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(animation), child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
      if (state is UsersStateInitial || state is UsersStateLoading) {
        return const CenteredProgressIndicator();
      } else if (state is UsersStateError) {
        return ApiExceptionWidget(apiException: state.apiException);
      } else if (state is UsersStateSuccess) {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          if (_scrollController!.hasClients) {
            _scrollController!.jumpTo(_usersBloc.scrollOffset);
          }
        });
        final users = state.users;
        return ListView.separated(
          controller: _scrollController,
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          itemCount: users?.length ?? 0,
          itemBuilder: (context, index) {
            var listItem = widget.useWideLayout
                ? _UserListItemWide(user: users![index], onTap: () => onUserTap(users[index], context))
                : _UserListItemThin(user: users![index], onTap: () => onUserTap(users[index], context));
            if (users[index] == _usersBloc.selectedUser) {
              listItem = Container(
                child: listItem,
                color: Colors.lightBlueAccent,
              );
            }
            return listItem;
          },
          separatorBuilder: (context, index) => const SizedBox(height: 4),
        );
      }
      return Container();
    });
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }
}

class _UserListItemThin extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;

  const _UserListItemThin({Key? key, required this.user, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (user.picture != null) NetworkImageWrapper().build(imageUrl: user.picture, width: 128, height: 128),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.title} ${user.firstName} ${user.lastName}',
              ),
              Text(user.email ?? ''),
            ],
          )
        ],
      ),
    );
  }
}

class _UserListItemWide extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;

  const _UserListItemWide({Key? key, required this.user, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (user.picture != null) NetworkImageWrapper().build(imageUrl: user.picture, width: 128, height: 128),
          const SizedBox(width: 8),
          Text('${user.title} ${user.firstName} ${user.lastName}'),
          Text(user.email ?? ''),
        ],
      ),
    );
  }
}
