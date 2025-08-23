class KException {
  final String message;
  final int? statusCode;

  KException(this.message, {this.statusCode});

  @override
  String toString() => 'KException{message: $message, statusCode: $statusCode}';
}
