import 'package:ecommerce/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:ecommerce/features/home/data/repositories/home_repository_impl.dart';
import 'package:ecommerce/features/home/domain/use_cases/product_use_case.dart';
import 'package:ecommerce/features/home/presentation/manager/home_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core.dart';
// import '../../features/login/data/datasources/auth_remote_data_source.dart';
// import '../../features/login/data/repositories/auth_repository_impl.dart';
// import '../../features/login/domain/usecases/login_usecase.dart';
// import '../../features/login/presentation/bloc/login_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<ConnectivityServiceRepositoryImpl>(
      () => ConnectivityServiceRepositoryImpl());

  // Register the singleton instance
  sl.registerLazySingleton<SecureStorageRepository>(
      () => SecureStorageRepositoryImpl());
  sl.registerLazySingleton<BaseApiServices>(() => NetworkApiService());

  // Register AuthRemoteDataSource and AuthRepository
  sl.registerSingleton<HomeRemoteDataSource>(
      HomeRemoteDataSource(sl<BaseApiServices>()));
  sl.registerSingleton<HomeRepositoryImpl>(
      HomeRepositoryImpl(sl<HomeRemoteDataSource>()));
  // Register UseCase
  sl.registerSingleton<ProductUseCase>(
      ProductUseCase(sl<HomeRepositoryImpl>()));

  // Register Bloc
  sl.registerFactory<ProductBloc>(() => ProductBloc(sl<ProductUseCase>()));
}
