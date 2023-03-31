import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/book_model.dart';
import '../../data/models/search_model.dart';
import '../../data/repositories/search_repo.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.searchRepo) : super(SearchInitial()) {
    on<ChangeSearchText>(_changeSearchText);
    on<LoadSearchResult>(_loadSearchResult);
  }

  final SearchRepo searchRepo;

  SearchModel searchModel = SearchModel(
    searchText: '',
  );

  void _changeSearchText(
    ChangeSearchText event,
    Emitter<SearchState> emit,
  ) {
    searchModel = searchModel.copyWith(searchText: event.searchText);
  }

  FutureOr<void> _loadSearchResult(
    LoadSearchResult event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchResultLoading());
    final res = await searchRepo.search(searchModel);
    res.fold(
      (failure) => emit(SearchResultLoadingFailed(failure.message)),
      (books) => emit(SearchResultLoadingSuccess(books)),
    );
  }
}
