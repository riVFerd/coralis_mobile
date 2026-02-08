import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.get('BASE_API_URL', fallback: 'http://localhost:3000'),
        sendTimeout: const Duration(minutes: 1),
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );
    return dio;
  }
}