import 'package:bookly_app/core/models/book_model.dart';
import 'package:bookly_app/core/utils/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/app_router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/helpers.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_shimmer.dart';
import '../book_rating.dart';

class NewestItemsGridView extends StatelessWidget {
  final List<BookModel> items;

  const NewestItemsGridView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            mainAxisExtent: 300.0),
        itemCount: items.length,
        itemBuilder: (context, index) => InkWell(
              onTap: () => GoRouter.of(context).push(
                AppRouter.bookDetailsView,
                extra: items[index],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.blueColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0)),
                        child: CachedNetworkImage(
                          imageUrl:
                              items[index].volumeInfo.imageLinks?.thumbnail ??
                                  '',
                          fit: BoxFit.cover,
                          height: 180,
                          width: double.infinity,
                          placeholder: (context, url) {
                            return CustomShimmer(radius: 10);
                          },
                          errorWidget: (context, url, error) {
                            return const Center(
                              child: Icon(
                                FontAwesomeIcons.circleExclamation,
                                size: 50,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[index].volumeInfo.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.textStyle18.copyWith(
                              fontFamily: kGTSectraFont,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            items[index].volumeInfo.authors!.join(', '),
                            style: Styles.textStyle14.copyWith(
                              color: Colors.white70,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (items[index].saleInfo != null)
                                Text(
                                  getPrice(items[index].saleInfo!),
                                  style: Styles.textStyle14
                                      .copyWith(color: Colors.white70),
                                ),
                              BookRating(
                                rating:
                                    items[index].volumeInfo.averageRating ?? 0,
                                count:
                                    items[index].volumeInfo.ratingsCount ?? 0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
