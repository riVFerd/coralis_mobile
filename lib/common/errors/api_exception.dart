class ApiException implements Exception {
  final String message;
  final Map<String, dynamic>? errorBag;

  ApiException(this.message, {this.errorBag});

  @override
  String toString() => message;
}