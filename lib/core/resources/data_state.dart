import 'package:dio/dio.dart';

abstract class DataState<T> {
  DataState({this.data, this.exception});
  final T? data;
  final DioException? exception;
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data);
}

class DataFailer<T> extends DataState<T> {
  DataFailer(DioException exception) : super(exception: exception);
}
