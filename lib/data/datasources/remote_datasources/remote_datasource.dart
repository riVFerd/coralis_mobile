import 'package:dio/dio.dart';
import 'package:coralis_test/common/errors/api_exception.dart';
import 'package:coralis_test/common/utils/logger.dart';
import 'package:coralis_test/data/datasources/session/session_source.dart';

/// Base class for all remote datasource
class RemoteDatasource {
  final Dio _dio;
  final SessionSource session;

  RemoteDatasource(this._dio, this.session);

  /// [T] is return type from [onResponse] network request
  /// [request] is the network request function which it's return type is param for [onResponse]
  /// throws [ApiException] if something went wrong
  Future<T> networkRequest<T>({
    required Future<Response> Function(Dio dio) request,
    required T Function(dynamic res) onResponse,
    bool isAuth = false,
  }) async {
    try {
      if (isAuth) {
        await _applyAuthHeader();
      } else {
        _dio.options.headers.remove("Authorization");
      }
      final response = await request(_dio);

      if (response.statusCode! >= 200 || response.statusCode! < 300) {

        if (response.data['success'] != true) {
          throw ApiException(
            response.data['message'],
            errorBag: response.data['errorBag'],
          );
        }

        logger.d(response.data);

        return onResponse(response.data);
      } else {
        throw ApiException(response.statusMessage ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      logger.e(e);

      if (e.response?.statusCode == 401) {
        await session.deleteToken();
        _dio.options.headers.remove("Authorization");
        throw ApiException('Unauthorized, please login again');
      }

      throw ApiException(e.message ?? 'Something went wrong');
    } catch (e) {
      logger.e(e);
      throw ApiException(e.toString());
    }
  }

  Future<void> _applyAuthHeader() async {
    final token = await session.token;
    if (token != null) {
      _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    } else {
      _dio.options.headers.remove("Authorization");
    }
  }
}
