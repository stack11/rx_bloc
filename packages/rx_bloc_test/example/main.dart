import 'package:flutter_test/flutter_test.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_test/rx_bloc_test.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  group('CounterBloc tests', () {
    rxBlocTest<CounterBloc, int>(
      'Basic rxBlocTest',
      build: () async => CounterBloc(),
      state: (bloc) => bloc.count,
      expect: [0],
    );

    rxBlocTest<CounterBloc, int>(
      'Executing action',
      build: () async => CounterBloc(),
      state: (bloc) => bloc.count,
      act: (bloc) async => bloc.increase(),
      expect: [0, 1],
    );

    rxBlocTest<CounterBloc, int>(
      'Skipping results (skips 0 and 1)',
      build: () async => CounterBloc(),
      state: (bloc) => bloc.count,
      act: (bloc) async {
        bloc.decrease();
        bloc.decrease();
      },
      skip: 2,
      expect: [-2],
    );
  });
}

class CounterBloc extends RxBlocBase {
  final _loadingCount = BehaviorSubject<int>.seeded(0);

  Stream<int> get count => _loadingCount.stream;

  void increase() => ++_loadingCount.value;
  void decrease() => --_loadingCount.value;

  @override
  dispose() {
    _loadingCount.close();
    return super.dispose();
  }
}