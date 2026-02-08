import 'dart:async';
import 'package:coralis_test/data/datasources/remote_datasources/remote_datasource.dart';
import 'package:coralis_test/data/models/user_model.dart';

class AuthRemoteDatasource extends RemoteDatasource {
  AuthRemoteDatasource(super.dio, super.session);

  Future<String> register(UserModel user) {
    return networkRequest(
      request: (dio) {
        return dio.post(
          '/auth/register',
          data: user.toJson(),
        );
      },
      onResponse: (data) => data.message,
    );
  }

  Future<UserModel> login(UserModel user) {
    return networkRequest(
      request: (dio) {
        return dio.post('/auth/login', data: user.toJson());
      },
      onResponse: (data) {
        session.setToken(data.token);
        return UserModel.fromJson(data.user);
      },
    );
  }

  Future<String> forgotPassword(String email) {
    return networkRequest(
      request: (dio) {
        return dio.post('/auth/forgot-password', data: {"email": email});
      },
      onResponse: (data) => data
          .resetToken, // For testing purpose, suppose to get the resetToken via email
    );
  }

  Future<String> resetPassword(String resetToken, String newPassword) {
    return networkRequest(
      request: (dio) {
        return dio.post('/auth/reset-password',
            data: {"resetToken": resetToken, "newPassword": newPassword});
      },
      onResponse: (data) => data.message,
    );
  }
}
