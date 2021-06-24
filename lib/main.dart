import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwebapp/blocs/user_posts_bloc/user_posts_bloc.dart';
import 'package:flutterwebapp/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:flutterwebapp/blocs/users_bloc/users_bloc.dart';
import 'package:flutterwebapp/routes.dart';
import 'package:flutterwebapp/services/api_service.dart';
import 'package:flutterwebapp/services/api_service_impl.dart';

FluroRouter? router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// final apiService = ApiServiceMock();
  final apiService = ApiServiceImpl('https://dummyapi.io/data/api', '603cc3f60cdc005ffaea05bf');
  router = FluroRouter();
  Routes.configureRoutes(router!);
  runApp(Application(apiService: apiService));
}

class Application extends StatelessWidget {
  final ApiService apiService;

  const Application({Key? key, required this.apiService}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UsersBloc(apiService: apiService)),
        BlocProvider(create: (_) => UserProfileBloc(apiService: apiService)),
        BlocProvider(create: (_) => UserPostsBloc(apiService: apiService))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: router!.generator,
        navigatorObservers: [observer],
      ),
    );
  }
}
