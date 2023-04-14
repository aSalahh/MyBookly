import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/styles.dart';

import '../../../../core/utils/app_colors.dart';

class BookRating extends StatelessWidget {
  const BookRating({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.rating,
    required this.count,
  });

  final int count;
  final MainAxisAlignment mainAxisAlignment;
  final num rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          FontAwesomeIcons.solidStar,
          color: AppColors.yellowColor,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: Styles.textStyle14,
        ),
        const SizedBox(width: 3),
        Text(
          '($count)',
          style: Styles.textStyle14.copyWith(
            color: AppColors.whiteColor.withOpacity(.5),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
