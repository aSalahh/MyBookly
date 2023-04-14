import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import 'draw_line_widget.dart';
import 'newest_items/main_newest_section.dart';
import 'featured_carousel_slider.dart';
import 'home_view_custom_app_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kMainHorizontalPadding,
              ),
              child: HomeViewCustomAppBar(),
            ),
            FeaturedCarouselSlider(),
            SizedBox(height: 20),
            DrawLine(),
            SizedBox(
              height: 10,
            ),
            NewestSection(),
          ],
        ));
  }
}
