import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:coralis_test/data/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:coralis_test/common/network/network_info.dart';
import 'package:coralis_test/common/storage/shared_pref_storage.dart';
import 'package:coralis_test/common/network/api_service.dart';
import 'package:coralis_test/data/datasources/session/session_source.dart';

import 'data/datasources/remote_datasources/auth_remote_datasource.dart';

final get = GetIt.instance;

void initializeDependencies() {
  get.registerLazySingleton<Dio>(() => ApiService.dio());
  get.registerSingleton<SharedPrefStorageInterface>(const SharedPrefStorage());
  get.registerLazySingleton<SessionSource>(() => SessionSource(shared: get.get()));
  get.registerLazySingleton<Connectivity>(() => Connectivity());
  get.registerLazySingleton(() => NetworkInfo(get.get()));
  get.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasource(get.get(), get.get()));
  get.registerLazySingleton<AuthRepository>(() => AuthRepository(get.get(), get.get()));
}
