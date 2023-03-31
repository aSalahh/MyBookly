import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required Animation<Offset> slidingAnimation,
  }) : _slidingAnimation = slidingAnimation;

  final Animation<Offset> _slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slidingAnimation,
      builder: (context, child) {
        return SlideTransition(
          position: _slidingAnimation,
          child:  Text(
            AppStrings.splashMessage,
            textAlign: TextAlign.center,
            style: Styles.textStyle16.copyWith(color: AppColors.orangeColor),
          ),
        );
      },
    );
  }
}
