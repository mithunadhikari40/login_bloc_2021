import 'dart:async';

import 'package:login_bloc/src/validators/auth_validator.dart';

class _AuthBloc  with AuthValidator{
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();
  final _genderController = StreamController<String>.broadcast();

  //getters for Functions
  // void  changeEmail(val) { _emailController.sink.add(val);}
  Function(String pass) get changeEmail => _emailController.sink.add;
  Function(String pass) get changePassword => _passwordController.sink.add;
  Function(String gender) get changeGender => _genderController.sink.add;

  //stream getters
  Stream<String> get emailStream => _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream => _passwordController.stream.transform(passwordValidator);
  Stream<String> get genderStream => _genderController.stream.transform(genderValidator);

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _genderController.close();
  }
}
final authBloc = _AuthBloc();
