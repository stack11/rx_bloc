import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:favorites_advanced_base/models.dart';
import 'package:equatable/equatable.dart';

part 'coordinator_event.dart';

part 'coordinator_state.dart';

class CoordinatorBloc extends Bloc<CoordinatorEvent, CoordinatorState> {
  CoordinatorBloc() : super(CoordinatorInitialState());

  final testList = <Puppy>[];

  @override
  Stream<Transition<CoordinatorEvent, CoordinatorState>> transformEvents(
    Stream<CoordinatorEvent> events,
    TransitionFunction<CoordinatorEvent, CoordinatorState> transitionFn,
  ) =>
      super.transformEvents(
        Rx.merge(
          [
            events,
            events
                .mapToPuppies()
                .map((puppies) => CoordinatorPuppiesUpdatedEvent(puppies))
          ],
        ),
        transitionFn,
      );

  @override
  Stream<CoordinatorState> mapEventToState(
    CoordinatorEvent event,
  ) async* {
    if (event is CoordinatorPuppiesUpdatedEvent) {
      // yield CoordinatorPuppiesUpdatedState(event.puppies);

      // print('Coordinator Bloc mapEventToState ${event.puppies}');
      // print('State.props: ${state.props}');
      // print('State.props.hashCode: ${state.props.hashCode}');
      // event.puppies.forEach((element) => print(element.hashCode));

      // yield CoordinatorPuppiesUpdatedState(event.puppies);
      // final test = CoordinatorPuppiesUpdatedState(event.puppies);
      // final test2 = test.copyWith(puppies: test.puppies);
      // print('test == test2  ${test == test2}');
      // print('${test.hashCode}  ${test2.hashCode}');
      // yield test.copyWith(puppies: test.puppies);

      // Yield an empty list
      yield CoordinatorPuppiesUpdatedState(testList);
      yield CoordinatorPuppiesUpdatedState(event.puppies);
    }
  }
}

extension _CoordinatorEventUtils on Stream<CoordinatorEvent> {
  Stream<List<Puppy>> mapToPuppies() => Rx.merge<List<Puppy>>(
        [
          whereType<CoordinatorPuppyUpdatedEvent>()
              .map((event) => [event.puppy]),
          whereType<CoordinatorPuppiesWithExtraDetailsEvent>()
              .map((event) => event.puppies)
              .doOnData((event1) {
            // print('Coordinator Bloc mapToPuppies : $event1');
          }),
        ],
      );
}
