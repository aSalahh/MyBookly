import 'dart:async';

import 'package:bookly_app/core/utils/app_enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/book_model.dart';
import '../../../../core/utils/shared_pref_manager.dart';
import '../../data/repositories/home_repo.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.homeRepo, this._sharedPrefManager) : super(HomeInitial()) {
    on<LoadFeaturedBooks>(_loadFeaturedBooks);
    on<LoadNewestBooks>(_loadNewestBooks);
    on<LoadSimilarBooks>(_loadSimilarBooks);
    on<ChangeView>(_changeNewestBooksViewState);
  }

  final HomeRepo homeRepo;
  final SharedPrefManager _sharedPrefManager;
  BooksView? selectedBooksView;
  List<BookModel> books = [];

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is ChangeView) {
      yield NewestBooksLoading();

      _sharedPrefManager
          .updateUserPreferredProductsView(selectedBooksView!.index);
      yield _getProductsView();
    }
    if (event is LoadFeaturedBooks) {
      yield FeaturedBooksLoading();
      final res = await homeRepo.fetchFeaturedBooks();
      yield res.fold(
        (failure) => FeaturedBooksLoadingFailed(failure.message),
        (books) => FeaturedBooksLoadingSuccess(books),
      );
    }
    if (event is LoadNewestBooks) {
      yield NewestBooksLoading();
      final res = await homeRepo.fetchNewestBooks();
      yield res.fold((failure) => NewestBooksLoadingFailed(failure.message),
          (books) {
        this.books = books;
        int index = _sharedPrefManager.getUserPreferredProductsView() ?? 0;
        selectedBooksView = BooksView.values.firstWhere(
            (element) => element.index == index,
            orElse: () => BooksView.Grid);

        return _getProductsView();
      });
    }
    if (event is LoadSimilarBooks) {
      yield SimilarBooksLoading();
      final res = await homeRepo.fetchSimilarBooks(
        category: event.category,
      );
      yield res.fold(
        (failure) => SimilarBooksLoadingFailed(failure.message),
        (books) => SimilarBooksLoadingSuccess(books),
      );
    }
  }

  Future<void> _loadFeaturedBooks(
    LoadFeaturedBooks event,
    Emitter<HomeState> emit,
  ) async {
    emit(FeaturedBooksLoading());
    final res = await homeRepo.fetchFeaturedBooks();
    res.fold(
      (failure) => emit(FeaturedBooksLoadingFailed(failure.message)),
      (books) => emit(FeaturedBooksLoadingSuccess(books)),
    );
  }

  Future<void> _changeNewestBooksViewState(
    ChangeView event,
    Emitter<HomeState> emit,
  ) async {
    _sharedPrefManager
        .updateUserPreferredProductsView(selectedBooksView!.index);
    emit(_getProductsView());
  }

  Future<void> _loadNewestBooks(
    LoadNewestBooks event,
    Emitter<HomeState> emit,
  ) async {
    emit(NewestBooksLoading());
    final res = await homeRepo.fetchNewestBooks();
    res.fold(
      (failure) => emit(NewestBooksLoadingFailed(failure.message)),
      (books) {
        this.books = books;
        int index = _sharedPrefManager.getUserPreferredProductsView() ?? 0;
        selectedBooksView = BooksView.values.firstWhere(
            (element) => element.index == index,
            orElse: () => BooksView.Grid);
        emit(NewestBooksLoadingSuccess(books));
        emit(_getProductsView());
      },
    );
  }

  Future<void> _loadSimilarBooks(
    LoadSimilarBooks event,
    Emitter<HomeState> emit,
  ) async {
    emit(SimilarBooksLoading());
    final res = await homeRepo.fetchSimilarBooks(
      category: event.category,
    );
    res.fold(
      (failure) => emit(
        SimilarBooksLoadingFailed(failure.message),
      ),
      (books) => emit(
        SimilarBooksLoadingSuccess(books),
      ),
    );
  }

  NewestBooksViewState _getProductsView() {
    switch (selectedBooksView) {
      case BooksView.List:
        return NewestBooksList(books);
      case BooksView.Scaled:
        return NewestBooksScale(books);
      default:
        return NewestBooksGrid(books);
    }
  }
}
