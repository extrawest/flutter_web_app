import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwebapp/blocs/user_posts_bloc/user_posts_bloc.dart';
import 'package:flutterwebapp/models/user_post.dart';
import 'package:flutterwebapp/utils/launch_helper.dart';
import 'package:flutterwebapp/utils/utils.dart';
import 'package:flutterwebapp/widgets/api_exception_widget.dart';
import 'package:flutterwebapp/widgets/centered_progress_indicator.dart';
import 'package:flutterwebapp/widgets/network_image_wrapper.dart';

class UserPostsWidget extends StatefulWidget {
  final String userId;
  final bool useWideLayout;

  const UserPostsWidget({Key? key, required this.userId, required this.useWideLayout}) : super(key: key);

  @override
  _UserPostsWidgetState createState() => _UserPostsWidgetState();
}

class _UserPostsWidgetState extends State<UserPostsWidget> with LaunchHelper {
  late UserPostsBloc _userPostsBloc;

  @override
  void initState() {
    super.initState();
    _userPostsBloc = BlocProvider.of<UserPostsBloc>(context);
    _userPostsBloc.add(LoadUserPostsEvent(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Material(
      child: BlocBuilder<UserPostsBloc, UserPostsState>(
        builder: (context, state) {
          if (state is UserPostsStateInitial || state is UserPostsStateLoading) {
            return const CenteredProgressIndicator();
          } else if (state is UserPostsStateError) {
            return ApiExceptionWidget(apiException: state.apiException);
          } else if (state is UserPostsStateSuccess) {
            final posts = state.posts;
            return ListView.builder(
              itemBuilder: (context, index) {
                final post = posts![index];
                return _userPostWidget(post: post, useWideLayout: widget.useWideLayout);
              },
              itemCount: posts?.length ?? 0,
            );
          }
          return const SizedBox();
        },
      ),
    ));
  }

  Widget _userPostWidget({required Post post, required bool useWideLayout}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // child: ElevatedButton(
      child: OutlinedButton(
          onPressed: (post.link == null) ? null : () => launchUrl(url: post.link!),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: useWideLayout ? _UserPostWide(post: post) : _UserPostThin(post: post),
          )),
    );
  }
}

class _UserPostThin extends StatelessWidget {
  final Post post;

  const _UserPostThin({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (post.image != null)
          Align(
              alignment: Alignment.center,
              child: NetworkImageWrapper().build(imageUrl: post.image, width: 200, height: 200)),
        if (post.text != null) Text(post.text!),
        _TagsWidget(isVertical: false, tags: post.tags),
        Row(
          children: [
            if (post.publishDate != null) Text(formatDateTime(post.publishDate)),
            const Spacer(),
            const Icon(Icons.favorite),
            const SizedBox(width: 8),
            Text("${post.likes ?? ''}"),
          ],
        )
      ],
    ));
  }
}

class _UserPostWide extends StatelessWidget {
  final Post post;

  const _UserPostWide({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.image != null) NetworkImageWrapper().build(imageUrl: post.image, width: 200, height: 200),
        if (post.text != null) Expanded(child: Center(child: Text(post.text!))),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _TagsWidget(isVertical: true, tags: post.tags),
            const SizedBox(height: 8),
            const Icon(Icons.favorite),
            const SizedBox(height: 4),
            Text("${post.likes ?? ''}"),
            if (post.publishDate != null) Text(formatDateTime(post.publishDate)),
          ],
        ),
      ],
    );
  }
}

class _TagsWidget extends StatelessWidget {
  final bool isVertical;
  final List<String>? tags;

  const _TagsWidget({Key? key, required this.isVertical, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < tags!.length; i++) _TagWidget(tag: tags![i]),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          for (int i = 0; i < tags!.length; i++) _TagWidget(tag: tags![i]),
        ],
      );
    }
  }
}

class _TagWidget extends StatelessWidget {
  final String tag;

  const _TagWidget({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tag.isNotEmpty) {
      return Padding(padding: const EdgeInsets.all(2.0), child: Chip(label: Text(tag)));
    }
    return const SizedBox();
  }
}
