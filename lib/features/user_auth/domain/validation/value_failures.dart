import 'package:jamoverflow/core/error/failure_interfaces.dart';

class NullUserIdFailure extends ValueFailure<String> {
  String _message;

  NullUserIdFailure(String input) : super(input) {
    _message = "UserId obtained from backend is null.";
  }

  @override
  List<Object> get props => [message];

  @override
  String get message => _message;
}
