import 'package:favorites_advanced_base/models.dart';
import 'package:favorites_advanced_base/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

import '../../../base/ui_components/error_widget.dart';
import '../../../base/ui_components/loading_widget.dart';
import '../../blocs/puppies_extra_details_bloc.dart';
import '../../details/blocs/puppy_manage_bloc.dart';
import '../blocs/puppy_list_bloc.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      RxResultBuilder<PuppyListBlocType, List<Puppy>>(
        state: (bloc) => bloc.states.searchedPuppies,
        buildLoading: (ctx, bloc) => LoadingWidget(),
        buildError: (ctx, error, bloc) => ErrorRetryWidget(
          onReloadTap: () => RxBlocProvider.of<PuppyListBlocType>(ctx)
              .events
              .reloadFavoritePuppies(silently: false),
        ),
        buildSuccess: (ctx, snapshot, bloc) => RefreshIndicator(
          onRefresh: () {
            bloc.events.reloadFavoritePuppies(silently: true);
            //TODO: replace this hardcoded duration with actual loaded event
            return Future.delayed(const Duration(seconds: 1));
          },
          child: SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 67),
              itemCount: snapshot.length,
              itemBuilder: (ctx, index) {
                final item = snapshot[index];

                return PuppyCard(
                  key: Key('${key.toString()}${item.id}'),
                  onVisible: (puppy) =>
                      RxBlocProvider.of<PuppiesExtraDetailsBlocType>(context)
                          .events
                          .fetchExtraDetails(puppy),
                  puppy: item,
                  onFavorite: (puppy, isFavorite) =>
                      RxBlocProvider.of<PuppyManageBlocType>(context)
                          .events
                          .markAsFavorite(puppy: puppy, isFavorite: isFavorite),
                );
              },
            ),
          ),
        ),
      );
}