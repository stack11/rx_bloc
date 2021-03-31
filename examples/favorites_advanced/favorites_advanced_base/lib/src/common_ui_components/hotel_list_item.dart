import 'package:favorites_advanced_base/models.dart';
import 'package:favorites_advanced_base/src/common_ui_components/skeleton_text.dart';
import 'package:favorites_advanced_base/src/theme/hotel_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:visibility_detector/visibility_detector.dart';

typedef OnFavorite = Function(Hotel hotel, bool isFavorite);
typedef OnVisible = Function(Hotel hotel);
typedef OnCardPressed = Function(Hotel hotel);

class HotelListItem extends StatelessWidget {
  final Hotel hotel;
  final OnFavorite _onFavorite;
  final Function(Hotel hotel)? _onVisible;
  final Function(Hotel hotel) _onCardPressed;

  const HotelListItem({
    required this.hotel,
    required OnFavorite onFavorite,
    required OnCardPressed onCardPressed,
    OnVisible? onVisible,
    Key? key,
  })  : _onFavorite = onFavorite,
        _onVisible = onVisible,
        _onCardPressed = onCardPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) => _onVisible == null
      ? _buildCard()
      : VisibilityDetector(
          onVisibilityChanged: (info) {
            if (info.visibleFraction > 0.7) {
              _onVisible!(hotel);
            }
          },
          key: Key("VisiblePuppyCard${hotel.id}"),
          child: _buildCard(),
        );

  Widget _buildCard() {
    return InkWell(
      onTap: () => _onCardPressed(hotel),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 2,
                child: Image.asset(
                  hotel.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: HotelAppTheme.buildLightTheme().backgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 8, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                hotel.title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: SkeletonText(
                                      text: hotel.displaySubtitle,
                                      height: 17,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  if (hotel.displayDist != null)
                                    Icon(
                                      FontAwesomeIcons.mapMarkerAlt,
                                      size: 12,
                                      color: HotelAppTheme.buildLightTheme()
                                          .primaryColor,
                                    ),
                                  Expanded(
                                    child: SkeletonText(
                                      text: hotel.displayDist == null
                                          ? null
                                          : '${hotel.displayDist!.toStringAsFixed(1)} km to city',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.withOpacity(0.8)),
                                      height: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  children: <Widget>[
                                    if (hotel.displayRating != null)
                                      SmoothStarRating(
                                        allowHalfRating: true,
                                        starCount: 5,
                                        rating: hotel.rating,
                                        size: 20,
                                        color: HotelAppTheme.buildLightTheme()
                                            .primaryColor,
                                        borderColor:
                                            HotelAppTheme.buildLightTheme()
                                                .primaryColor,
                                      ),
                                    Expanded(
                                      child: SkeletonText(
                                        text: hotel.displayReviews == null
                                            ? null
                                            : ' ${hotel.displayReviews!} Reviews',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                        height: 19,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, top: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '\$${hotel.perNight}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            '/per night',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () => _onFavorite(hotel, !hotel.isFavorite),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    hotel.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: HotelAppTheme.buildLightTheme().primaryColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}