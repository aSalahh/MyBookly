import 'package:flutter/cupertino.dart';

import '../widgets/custom_shimmer.dart';

const int kSplashAnimationDurationWithMS = 1000;
const Duration kTransitionDuration = Duration(milliseconds: 250);
const String kGTSectraFont = 'GT Sectra';
const double kMainHorizontalPadding = 30.0;
const String kPreferredProductsViewKey = "PREFERRED_PRODUCTS_VIEW_KEY";
final List<Widget> kFailureCarouselSliderShimmer = List.generate(
    10,
    (index) => const CustomShimmer(radius: 10));
