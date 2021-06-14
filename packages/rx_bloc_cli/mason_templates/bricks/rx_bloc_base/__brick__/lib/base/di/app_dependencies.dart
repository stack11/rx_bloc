// Copyright (c) 2021, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dio/dio.dart'; {{#analytics}}
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart'; {{/analytics}}
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../app/config/environment_config.dart';
import '../common_blocs/user_account_bloc.dart';
import '../common_use_cases/fetch_access_token_use_case.dart';
import '../common_use_cases/login_use_case.dart';
import '../common_use_cases/logout_use_case.dart';
import '../data_sources/local/auth_token_data_source.dart';
import '../data_sources/local/auth_token_shared_dara_source.dart';
import '../data_sources/remote/auth_data_source.dart';
import '../data_sources/remote/interceptors/analytics_interceptor.dart';
import '../data_sources/remote/interceptors/auth_interceptor.dart';
import '../data_sources/remote/push_notification_data_source.dart';
import '../repositories/auth_repository.dart';
import '../repositories/push_notification_subscription_repository.dart';
import '../repositories/user_authentication_repository.dart';

class AppDependencies {
  AppDependencies._(this.context, this.config);

  factory AppDependencies.of(
          BuildContext context, EnvironmentConfig envConfig) =>
      _instance != null
          ? _instance!
          : _instance = AppDependencies._(context, envConfig);

  static AppDependencies? _instance;

  final BuildContext context;
  final EnvironmentConfig config;

  /// List of all providers used throughout the app
  ///
  List<SingleChildWidget> get providers => [ {{#analytics}}
        ..._analytics,{{/analytics}}
        ..._dataSources,
        ..._repositories,
        ..._useCases,
        ..._blocs,
        ..._httpClients,
      ];

  {{#analytics}}

  List<Provider> get _analytics => [
        Provider<FirebaseAnalytics>(create: (context) => FirebaseAnalytics()),
        Provider<FirebaseAnalyticsObserver>(
          create: (context) =>
              FirebaseAnalyticsObserver(analytics: context.read()),
        ),
      ]; {{/analytics}}

  List<Provider> get _httpClients => [
    Provider<Dio>(create: (context) {
      final _dio = Dio();
      _dio.interceptors
        ..add(AuthInterceptor(context.read(), context.read()))
      {{#analytics}}..add(AnalyticsInterceptor(context.read())){{/analytics}};
      return _dio;
    }),
  ];

  /// Chose one of both implemented AuthTokenDataSources or create your own
  List<Provider> get _dataSources => [
        Provider<AuthTokenDataSource>(
            create: (context) => AuthTokenSharedDataSource()),
        // create: (context) => AuthTokenSecureDataSource()),
        Provider<AuthDataSource>(
          create: (context) =>
              AuthDataSource(context.read(), baseUrl: config.baseApiUrl),
        ),
        Provider<PushNotificationsDataSource>(
          create: (context) => PushNotificationsDataSource(context.read(),
              baseUrl: config.baseApiUrl),
        ),
      ];

  List<Provider> get _repositories => [
        Provider<AuthRepository>(
            create: (context) => AuthRepository(context.read())),
        Provider<UserAuthRepository>(
            create: (context) => UserAuthRepository(context.read())),
        Provider<PushNotificationSubscriptionRepository>(
          create: (context) =>
              PushNotificationSubscriptionRepository(context.read()),
        ),
      ];

  List<Provider> get _useCases => [
        Provider<LoginUseCase>(
            create: (context) => LoginUseCase(context.read())),
        Provider<LogoutUseCase>(
            create: (context) => LogoutUseCase(context.read())),
        Provider<FetchAccessTokenUseCase>(
            create: (context) => FetchAccessTokenUseCase(context.read())),
      ];

  List<SingleChildWidget> get _blocs => [
        Provider<UserAccountBlocType>(
          create: (context) => UserAccountBloc(
            context.read(),
            context.read(),
          ),
        ),
      ];
}
