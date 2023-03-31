import 'package:flutter/material.dart';

import 'custom_search_text_field.dart';
import 'search_result_section.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CustomSearchTextField(),
          SizedBox(height: 15),
          Expanded(child: SearchResultSection()),
        ],
      ),
    );
  }
}
