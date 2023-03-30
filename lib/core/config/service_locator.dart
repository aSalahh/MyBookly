import 'package:bookly_app/core/utils/shared_pref_manager.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/data/datasources/local/home_local_datasource.dart';
import '../../features/home/data/datasources/local/home_local_datasource_impl.dart';
import '../../features/home/data/datasources/remote/home_remote_datasource.dart';
import '../../features/home/data/datasources/remote/home_remote_datasource_impl.dart';
import '../../features/home/data/repositories/home_repo.dart';
import '../../features/home/data/repositories/home_repo_impl.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/search/data/datasources/remote/search/search_remote_datasource.dart';
import '../../features/search/data/datasources/remote/search/search_remote_datasource_impl.dart';
import '../../features/search/data/repositories/search_repo.dart';
import '../../features/search/data/repositories/search_repo_impl.dart';
import '../../features/search/presentation/bloc/search_bloc.dart';
import '../api/api_service.dart';
import '../api/dio_api_service.dart';
import 'connectivity_checker.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  _initCore();
  _initHomeFeature();
  _initSearchFeature();
}

void _initCore() {
  getIt.registerLazySingleton<DioApiService>(() => DioApiService(Dio()));

  getIt.registerLazySingleton<ApiService>(
    () => getIt<DioApiService>(),
  );
  getIt.registerLazySingleton<BaseCheckInternetConnectivity>(
    () => CheckInternetConnectivity(),
  );
}

void _initHomeFeature() {
  getIt.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(getIt<DioApiService>()),
  );
  getIt.registerLazySingleton<HomeLocalDatasource>(
    () => HomeLocalDatasourceImpl(),
  );

  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(
      homeRemoteDatasource: getIt<HomeRemoteDatasource>(),
      homeLocalDatasource: getIt<HomeLocalDatasource>(),
      baseCheckInternetConnectivity: getIt<BaseCheckInternetConnectivity>(),
    ),
  );

  getIt.registerLazySingleton<SharedPrefManager>(
        () => SharedPrefManager()

  );

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(getIt<HomeRepo>(),getIt<SharedPrefManager>()),
  );
}

void _initSearchFeature() {
  getIt.registerLazySingleton<SearchRemoteDatasource>(
    () => SearchRemoteDatasourceImpl(getIt<DioApiService>()),
  );

  getIt.registerLazySingleton<SearchRepo>(
    () => SearchRepoImpl(getIt<SearchRemoteDatasource>()),
  );

  getIt.registerFactory<SearchBloc>(
    () => SearchBloc(getIt<SearchRepo>()),
  );
}
