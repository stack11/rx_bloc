// Copyright (c) 2021, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../base/data_sources/domain/counter/count_data_source.dart';
import '../../base/data_sources/domain/counter/count_local_data_source.dart';
import '../../base/data_sources/domain/counter/count_remote_data_source.dart';
import '../../base/repositories/counter_repository.dart';
import '../blocs/counter_bloc.dart';

class CounterDependencies {
  CounterDependencies._(this.context);

  factory CounterDependencies.of(BuildContext context) => _instance != null
      ? _instance!
      : _instance = CounterDependencies._(context);

  static CounterDependencies? _instance;

  final BuildContext context;

  List<SingleChildWidget> get providers => [
        ..._dataSources,
        ..._repositories,
        ..._blocs,
      ];

  /// In case your application use API and HttpClient(dio and retrofit
  /// by default), here should uncomment the row with CountRemoteDataSource
  /// and comment current "create" function, witch use CountLocalDataSource.
  /// Also you should provide a real api in
  /// lib\base\data_sources\domain\counter\count_remote_data_source.dart
  /// and data models in lib\base\models and rerun build_runner.
  List<Provider> get _dataSources => [
    Provider<CountDataSource>(
      // create: (context) => CountRemoteDataSource(context.read()),
      create: (context) => CountLocalDataSource(),
    ),
      ];

  List<Provider> get _repositories => [
        Provider<CounterRepository>(
          create: (context) => CounterRepository(context.read()),
        ),
      ];

  List<RxBlocProvider> get _blocs => [
        RxBlocProvider<CounterBlocType>(
          create: (context) => CounterBloc(context.read()),
        ),
      ];
}
