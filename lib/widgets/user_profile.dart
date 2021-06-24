import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwebapp/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:flutterwebapp/models/user_profile.dart';
import 'package:flutterwebapp/utils/constants.dart';
import 'package:flutterwebapp/utils/utils.dart';
import 'package:flutterwebapp/widgets/api_exception_widget.dart';
import 'package:flutterwebapp/widgets/centered_progress_indicator.dart';
import 'package:flutterwebapp/widgets/network_image_wrapper.dart';
import 'package:flutterwebapp/widgets/phone_number_widget.dart';
import 'package:flutterwebapp/widgets/user_email_widget.dart';

class UserProfileWidget extends StatefulWidget {
  final String userId;
  final OpenPostsCallback onOpenPosts;
  final bool useWideLayout;

  const UserProfileWidget({Key? key, required this.userId, required this.onOpenPosts, required this.useWideLayout}) : super(key: key);

  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  late UserProfileBloc _userProfileBloc;

  @override
  void initState() {
    super.initState();
    _userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    _userProfileBloc.add(LoadUserProfileEvent(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileStateInitial || state is UserProfileStateLoading) {
              return const CenteredProgressIndicator();
            } else if (state is UserProfileStateError) {
              return ApiExceptionWidget(apiException: state.apiException);
            } else if (state is UserProfileStateSuccess) {
              return widget.useWideLayout
                  ? _UserProfileWide(user: state.userProfile, onOpenPosts: _showPostsByUser)
                  : _UserProfileThin(user: state.userProfile, onOpenPosts: _showPostsByUser);
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _showPostsByUser() {
    widget.onOpenPosts(widget.userId);
  }
}

class _UserProfileThin extends StatelessWidget {
  final UserProfile user;
  final VoidCallback onOpenPosts;

  const _UserProfileThin({Key? key, required this.user, required this.onOpenPosts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (user.picture != null)
            Align(alignment: Alignment.centerLeft, child: NetworkImageWrapper().build(imageUrl: user.picture, width: 200, height: 200)),
          _PaddedText('${user.title} ${user.firstName} ${user.lastName}'),
          if (user.dateOfBirth != null) _PaddedText('$birthdate ${formatDate(user.dateOfBirth)}'),
          if (user.registerDate != null) _PaddedText('$registrationDate ${formatDate(user.registerDate)}'),
          if (user.location != null)
            _PaddedText('${user.location!.country} ${user.location!.state} ${user.location!.city} ${user.location!.street}'),
          if (user.phone != null) PhoneNumberWidget(phoneNumber: user.phone),
          if (user.email != null) UserEmailWidget(email: user.email),
          OutlinedButton(child: const Text(postsByUser), onPressed: onOpenPosts),
        ],
      ),
    );
  }
}

class _UserProfileWide extends StatelessWidget {
  final UserProfile user;
  final VoidCallback onOpenPosts;

  const _UserProfileWide({Key? key, required this.user, required this.onOpenPosts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('${user.title} ${user.firstName} ${user.lastName}'),
        if (user.location != null)
          _PaddedText('${user.location!.country} ${user.location!.state} ${user.location!.city} ${user.location!.street}'),
        Row(
          children: [
            if (user.dateOfBirth != null) Expanded(child: _PaddedText('$birthdate ${formatDate(user.dateOfBirth)}')),
            if (user.registerDate != null) Expanded(child: _PaddedText('$registrationDate ${formatDate(user.registerDate)}')),
          ],
        ),
        Row(
          children: [
            if (user.phone != null) Flexible(child: PhoneNumberWidget(phoneNumber: user.phone)),
            if (user.email != null) Flexible(child: UserEmailWidget(email: user.email))
          ],
        ),
        TextButton(onPressed: onOpenPosts, child: const Text(postsByUser))
      ]),
    );
  }
}

class _PaddedText extends StatelessWidget {
  final String text;
  final double verticalPadding;

  const _PaddedText(this.text, {Key? key, this.verticalPadding = 4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Text(text),
    );
  }
}
