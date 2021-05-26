import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jamoverflow/core/services/parse_service.dart';
import 'package:jamoverflow/features/user_auth/presentation/states/login_details.dart';
import 'package:jamoverflow/core/shared/network_info.dart';
import 'package:jamoverflow/features/user_auth/data/datasources/auth_datasource.dart';
import 'package:jamoverflow/features/user_auth/data/repositories/auth.dart';
import 'package:jamoverflow/features/user_auth/domain/entities/user.dart';
import 'package:jamoverflow/features/user_auth/domain/usecases/signin.dart';
import 'package:jamoverflow/features/user_auth/domain/usecases/signup.dart';

final backendProvider = Provider((ref) => ParseService());

// Singleton class for userProvider
class SingleUser {
  SingleUser._internal();
  static final SingleUser _singleUser = SingleUser._internal();
  Provider<User> _userProvider;
  get getUserProvider => _userProvider;
  factory SingleUser(Provider<User> userProvider) {
    // if (_singleUser._userProvider == null)
    _singleUser._userProvider = userProvider;
    return _singleUser;
  }
}

SingleUser singleUser;

// Signin Usecase Provider
final signinUsecaseProvider = Provider<SignIn>((ref) {
  final backend = ref.read(backendProvider);
  final internetConnectionChecker = InternetConnectionChecker();
  final networkInfo = NetworkInfo(internetConnectionChecker);
  final authDataSource =
      AuthDataSource(service: backend, networkInfo: networkInfo);
  final authContract = Auth(dataSource: authDataSource);
  final usecase = SignIn(authContract);
  return usecase;
});

// Signup Usecase Provider
final signupUsecaseProvider = Provider<SignUp>((ref) {
  final backend = ref.read(backendProvider);
  final internetConnectionChecker = InternetConnectionChecker();
  final networkInfo = NetworkInfo(internetConnectionChecker);
  final authDataSource =
      AuthDataSource(service: backend, networkInfo: networkInfo);
  final authContract = Auth(dataSource: authDataSource);
  final usecase = SignUp(authContract);
  return usecase;
});

class LoginDetailsReaderClient {
  Future<LoginDetails> get(String boxName) async {
    var box = await Hive.openBox(boxName);
    return LoginDetails(
      saveStatus: box.get('isSaved', defaultValue: false),
      email: box.get('email'),
      password: box.get('password'),
    );
  }
}

final loginDetailsReaderClientProvider =
    Provider((ref) => LoginDetailsReaderClient());

final loginDetailsProvider =
    FutureProvider.family<LoginDetails, String>((ref, boxName) async {
  final loginDetailsReaderClient = ref.read(loginDetailsReaderClientProvider);
  return loginDetailsReaderClient.get(boxName);
});
