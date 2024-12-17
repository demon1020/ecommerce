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
  // sl.registerSingleton<AuthRemoteDataSource>(
  //     AuthRemoteDataSource(sl<BaseApiServices>()));
  // sl.registerSingleton<AuthRepositoryImpl>(
  //     AuthRepositoryImpl(sl<AuthRemoteDataSource>()));
  // // Register UseCase
  // sl.registerSingleton<LoginUseCase>(LoginUseCase(sl<AuthRepositoryImpl>()));
  //
  // // Register Bloc
  // sl.registerFactory<LoginBloc>(() => LoginBloc(sl<LoginUseCase>()));
}
