import 'package:flutter/material.dart';

import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/styles.dart';
import 'build_option_icon.dart';
import 'newest_items_list_view.dart';

class NewestSection extends StatelessWidget {
  const NewestSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kMainHorizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Row(
            children: const [
              Text(AppStrings.newestBooks, style: Styles.textStyle18),
              Spacer(),
              BuildOptionIcons(booksView: BooksView.Grid , icon: Icons.grid_on,),
              BuildOptionIcons(booksView: BooksView.List , icon: Icons.list,),
            ],
          ),
          SizedBox(height: 20),
          NewestItemsListView(),
        ],
      ),
    );
  }
}
