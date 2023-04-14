import 'package:bookly_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:bookly_app/features/home/presentation/widgets/newest_items/newest_items_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_enums.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../build_option_icon.dart';
import 'newest_items_list_view.dart';
import 'newest_items_scaled_view.dart';

class NewestSection extends StatelessWidget {
  const NewestSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kMainHorizontalPadding,
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Row(
                children: const [
                  Text(AppStrings.newestBooks, style: Styles.textStyle18),
                  Spacer(),
                  BuildOptionIcons(booksView: BooksView.Grid , icon: Icons.grid_on,),
                  BuildOptionIcons(booksView: BooksView.List , icon: Icons.list,),
                  BuildOptionIcons(booksView: BooksView.Scaled , icon: Icons.crop_square,),
                ],
              ),
              const SizedBox(height: 20),
              _buildProductsView(state)        ],
          );
        },
      ),
    );
  }
  Widget _buildProductsView(HomeState state) {
    if (state is NewestBooksList) {
      return NewestItemsListView(items: state.items);
    }
    if (state is NewestBooksGrid) {
      return NewestItemsGridView(items: state.items);
    }
    if (state is NewestBooksScale) {
      return NewestItemsScaledView(items: state.items);
    }
    if (state is NewestBooksLoadingFailed) {
      return CustomErrorWidget(message: state.message);
    }
    return Center(child: CircularProgressIndicator());
  }
}
