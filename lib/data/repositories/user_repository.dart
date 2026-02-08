import 'package:coralis_test/common/errors/app_error.dart';
import 'package:coralis_test/data/repositories/repository.dart';

import '../datasources/remote_datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepository extends Repository {
  final UserRemoteDatasource _datasource;

  UserRepository(super.networkInfo, this._datasource);

  FutureResponse<UserModel> profile() {
    return handleNetworkCall(
      call: _datasource.profile(),
      onSuccess: (data) => data,
    );
  }
}
