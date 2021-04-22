import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

import '../../feature_home/models/navigation_state.dart';
import '../../feature_puppy/favorites/models/favorite_list_state.dart';
import '../../feature_puppy/search/models/puppy_list_state.dart';

@immutable
class AppState extends Equatable {
  const AppState({
    required this.navigationState,
    required this.puppyListState,
    required this.favoriteListState,
    required this.favoriteCount,
    required this.error,
  });

  factory AppState.initialState() => AppState(
        navigationState: NavigationState.initialState(),
        puppyListState: PuppyListState.initialState(),
        favoriteListState: FavoriteListState.initialState(),
        favoriteCount: 0,
        error: '',
      );

  final NavigationState navigationState;
  final PuppyListState puppyListState;
  final FavoriteListState favoriteListState;
  final int favoriteCount;
  final String error;

  AppState copyWith(
          {NavigationState? navigationState,
          PuppyListState? puppyListState,
          FavoriteListState? favoriteListState,
          int? favoriteCount,
          String? error}) =>
      AppState(
        navigationState: navigationState ?? this.navigationState,
        puppyListState: puppyListState ?? this.puppyListState,
        favoriteListState: favoriteListState ?? this.favoriteListState,
        favoriteCount: favoriteCount ?? this.favoriteCount,
        error: error ?? this.error,
      );

  @override
  List<Object> get props => [
        navigationState,
        puppyListState,
        favoriteListState,
        favoriteCount,
        error,
      ];
}
