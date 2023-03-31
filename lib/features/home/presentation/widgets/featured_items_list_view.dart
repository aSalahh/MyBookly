import 'package:bookly_app/core/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/models/book_model.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_shimmer.dart';
import '../bloc/home_bloc.dart';

class FeaturedItemsListView extends StatelessWidget {
  const FeaturedItemsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.3,
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) {
          if (current is FeaturedBooksLoading ||
              current is FeaturedBooksLoadingSuccess ||
              current is FeaturedBooksLoadingFailed) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is FeaturedBooksLoadingSuccess) {
            return CarouselSlider(
              options: CarouselOptions(
                height: 230,
                viewportFraction: 0.44,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
              ),
              items: getImageSliders(state.books),
            );
          } else if (state is FeaturedBooksLoadingFailed) {
            return CustomErrorWidget(message: state.message);
          } else {
            return CarouselSlider(
                options: CarouselOptions(
                  height: 230,
                  viewportFraction: 0.44,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                ),
                items: kFailureCarouselSliderShimmer);
          }
        },
      ),
    );
  }

  List<Widget> getImageSliders(List<BookModel> items) {
    return items
        .map((item) => Container(
              child: Container(
                margin: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 230,
                      width: 155,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: item.volumeInfo.imageLinks?.thumbnail ?? '',
                        fit: BoxFit.fill,
                        placeholder: (context, url) {
                          return const AspectRatio(
                            aspectRatio: 2.6 / 4,
                            child: CustomShimmer(radius: 10),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return const Icon(
                            FontAwesomeIcons.circleExclamation,
                            size: 50,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ))
        .toList();
  }
}
