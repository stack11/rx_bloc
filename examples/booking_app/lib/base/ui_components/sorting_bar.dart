import 'package:booking_app/feature_hotel/search/blocs/hotel_list_bloc.dart';
import 'package:favorites_advanced_base/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

class SortingBar extends SliverPersistentHeaderDelegate {
  SortingBar({
    this.onPressed,
  });

  final Function(HotelListBlocType, SortBy)? onPressed;

  @override
  double get maxExtent => 52;

  @override
  double get minExtent => 52;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: DesignSystem.of(context).colors.backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, -2),
                      blurRadius: 8),
                ],
              ),
            ),
          ),
          Container(
            color: DesignSystem.of(context).colors.backgroundColor,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: RxBlocBuilder<HotelListBlocType, String>(
                        state: (bloc) => bloc.states.hotelsFound,
                        builder: (context, snapshot, bloc) => Text(
                          snapshot.data ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  RxBlocBuilder<HotelListBlocType, SortBy>(
                    state: (bloc) => bloc.states.sortedBy,
                    builder: (context, sortByState, bloc) => FocusButton(
                      onPressed: () {
                        onPressed?.call(bloc, sortByState.data ?? SortBy.none);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            const Text(
                              'Sort',
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.sort,
                                color: DesignSystem.of(context)
                                    .colors
                                    .primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Divider(
              height: 1,
            ),
          )
        ],
      );
}
