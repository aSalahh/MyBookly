import 'package:bookly_app/core/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/book_shimmer.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/detailed_book_item.dart';
import '../../bloc/home_bloc.dart';

class NewestItemsScaledView extends StatelessWidget {
  final List<BookModel> items;
  const NewestItemsScaledView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: DetailedBookItem(book: items[index]),
      ),
      itemCount: items.length,
    );
  }
}
