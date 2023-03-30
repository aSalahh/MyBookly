import 'package:bookly_app/core/utils/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
class BuildOptionIcons extends StatefulWidget {
  final IconData icon;
  final BooksView booksView;
  const BuildOptionIcons({Key? key, required this.icon,required this.booksView}) : super(key: key);

  @override
  State<BuildOptionIcons> createState() => _BuildOptionIconsState();
}

class _BuildOptionIconsState extends State<BuildOptionIcons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (BlocProvider.of<HomeBloc>(context).selectedBooksView != widget.booksView) {
          setState(() {
            BlocProvider.of<HomeBloc>(context).selectedBooksView = widget.booksView;
            changeView();
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          widget.icon,
          size: 22,
          color: BlocProvider.of<HomeBloc>(context).selectedBooksView == widget.booksView
              ?  const Color(0xffe1739e)
              :  const Color(0xFF767676),
        ),
      ),
    );
  }
  void changeView() {
    BlocProvider.of<HomeBloc>(context).add(ChangeView());
  }
}
