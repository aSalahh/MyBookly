import 'package:bookly_app/core/models/book_model.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/book_shimmer.dart';
import '../../../../../core/widgets/detailed_book_item.dart';

class NewestItemsListView extends StatelessWidget {
  final List<BookModel> items;

  const NewestItemsListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return items.isNotEmpty
        ? ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: DetailedBookItem(book: items[index]),
            ),
            itemCount: items.length,
          )
        : ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: BookShimmer(),
            ),
            itemCount: 10,
            scrollDirection: Axis.vertical,
          );
  }
}
