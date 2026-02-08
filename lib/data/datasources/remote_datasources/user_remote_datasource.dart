import 'package:coralis_test/data/datasources/remote_datasources/remote_datasource.dart';

import '../../models/user_model.dart';

class UserRemoteDatasource extends RemoteDatasource {
  UserRemoteDatasource(super.dio, super.session);

  Future<UserModel> profile() {
    return networkRequest(
      request: (dio) {
        return dio.get('/user/profile');
      },
      onResponse: (data) => UserModel.fromJson(data),
      isAuth: true,
    );
  }
}
