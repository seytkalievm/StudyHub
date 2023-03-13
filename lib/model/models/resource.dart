class Resource<T> {
  T? data;
  String? message;
  int? errorCode;
  Resource({this.data, this.message, this.errorCode});
}

class Success<T> extends Resource<T> {
  T successData;
  Success({required this.successData}) : super(data: successData);
}

class Fail<T> extends Resource<T> {
  String errorMessage;
  int? statusCode;
  Fail({required this.errorMessage, this.statusCode})
      : super(message: errorMessage, errorCode: statusCode);
}
