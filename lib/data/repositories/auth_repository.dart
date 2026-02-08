import 'package:coralis_test/common/errors/app_error.dart';
import 'package:coralis_test/data/models/user_model.dart';
import 'package:coralis_test/data/repositories/repository.dart';

import '../datasources/remote_datasources/auth_remote_datasource.dart';

class AuthRepository extends Repository {
  final AuthRemoteDatasource _datasource;

  AuthRepository(super.networkInfo, this._datasource);

  FutureResponse<String> register(UserModel user) {
    return handleNetworkCall(
      call: _datasource.register(user),
      onSuccess: (data) => data,
    );
  }

  FutureResponse<UserModel> login(UserModel user) {
    return handleNetworkCall(
      call: _datasource.login(user),
      onSuccess: (data) => data,
    );
  }

  FutureResponse<String> forgotPassword(String email) {
    return handleNetworkCall(
      call: _datasource.forgotPassword(email),
      onSuccess: (data) => data,
    );
  }

  FutureResponse<String> resetPassword(String resetToken, String newPassword) {
    return handleNetworkCall(
      call: _datasource.resetPassword(resetToken, newPassword),
      onSuccess: (data) => data,
    );
  }
}
