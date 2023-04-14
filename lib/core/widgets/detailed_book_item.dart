import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_router.dart';
import '../../../../core/models/book_model.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/styles.dart';
import '../../features/home/data/models/book_model/sale_info.dart';
import '../../features/home/presentation/widgets/book_rating.dart';
import '../../features/home/presentation/widgets/custom_book_image.dart';
import '../utils/helpers.dart';

class DetailedBookItem extends StatelessWidget {
  const DetailedBookItem({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => GoRouter.of(context).push(
        AppRouter.bookDetailsView,
        extra: book,
      ),
      child: SizedBox(
        height: 125,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 2.6 / 4,
              child: CustomBookImage(
                imageUrl: book.volumeInfo.imageLinks?.thumbnail ?? '',
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.screenWidth * .5,
                    child: Text(
                      book.volumeInfo.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textStyle20.copyWith(
                        fontFamily: kGTSectraFont,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  if (book.volumeInfo.authors != null)
                    Text(
                      book.volumeInfo.authors!.join(', '),
                      style: Styles.textStyle14.copyWith(
                        color: Colors.white70,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (book.saleInfo != null)
                        Text(
                          getPrice(book.saleInfo!),
                          style: Styles.textStyle18.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white70),
                        ),
                      BookRating(
                        rating: book.volumeInfo.averageRating ?? 0,
                        count: book.volumeInfo.ratingsCount ?? 0,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
