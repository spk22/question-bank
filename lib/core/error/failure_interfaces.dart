import 'package:equatable/equatable.dart';

abstract class ValueFailure<T> extends Equatable {
  String get message;
  ValueFailure(T input);
}

abstract class InfraFailure<Exception> extends Equatable {
  String get message;
  InfraFailure(Exception e);
}
