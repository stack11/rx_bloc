import 'package:favorites_advanced_base/core.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:booking_app/base/repositories/paginated_hotels_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/common_blocs/coordinator_bloc.dart';

part 'hotel_manage_bloc.rxb.g.dart';
part 'hotel_manage_bloc_extensions.dart';

// ignore: one_member_abstracts
abstract class HotelManageEvents {
  void markAsFavorite({required Hotel hotel, required bool isFavorite});
}

abstract class HotelManageStates {
  @RxBlocIgnoreState()
  Stream<bool> get isLoading;

  @RxBlocIgnoreState()
  Stream<String> get error;
}

@RxBloc()
class HotelManageBloc extends $HotelManageBloc {
  HotelManageBloc(PaginatedHotelsRepository hotelsRepository,
      CoordinatorBlocType coordinatorBloc)
      : _hotelsRepository = hotelsRepository,
        _coordinatorBloc = coordinatorBloc {
    //For a more detailed explanation reference this article:
    //https://medium.com/prime-holding-jsc/building-complex-apps-in-flutter-with-the-power-of-reactive-programming-54a38fbc0cde
    _$markAsFavoriteEvent
        //use an extension which handles marking the hotel as favourite
        //without delay between the event and the response
        .markHotelAsFavorite(hotelsRepository, this)
        //notify the coordinator bloc that the hotel has been changed
        .doOnData((hotel) => coordinatorBloc.events.hotelUpdated(hotel))
        .bind(_lastUpdatedHotel)
        .disposedBy(_compositeSubscription);
  }

  final PaginatedHotelsRepository _hotelsRepository;
  final CoordinatorBlocType _coordinatorBloc;

  final _lastUpdatedHotel = BehaviorSubject<Hotel>();
  final _favoriteHotelError = PublishSubject<Exception>();

  @override
  Stream<String> get error =>
      Rx.merge([errorState, _favoriteHotelError]).mapToString().share();

  @override
  Stream<bool> get isLoading => loadingState.shareReplay(maxSize: 1);

  @override
  void dispose() {
    _favoriteHotelError.close();
    _lastUpdatedHotel.close();
    super.dispose();
  }
}