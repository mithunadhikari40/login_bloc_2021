import 'dart:async';

import 'package:login_bloc/src/api/auth_api.dart';
import 'package:login_bloc/src/validators/auth_validator.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject,Rx;

class AuthBloc  with AuthValidator{
  final api = AuthApi();


  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _genderController = BehaviorSubject<String>();
  //to hold the status of the button's child
  final _loadingController = BehaviorSubject<bool>();

  //getters for Functions
  // void  changeEmail(val) { _emailController.sink.add(val);}
  Function(String pass) get changeEmail => _emailController.sink.add;
  Function(String pass) get changePassword => _passwordController.sink.add;
  Function(String gender) get changeGender => _genderController.sink.add;
  Function(bool val) get changeLoadingStatus => _loadingController.sink.add;

  //stream getters
  Stream<String> get emailStream => _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream => _passwordController.stream.transform(passwordValidator);
  Stream<String> get genderStream => _genderController.stream.transform(genderValidator);
  Stream<bool> get loadingStatusStream => _loadingController.stream;

  //todo combine 3 streams
 Stream<bool> get buttonStream => Rx.combineLatest3(emailStream, passwordStream, genderStream,
         (a, b, c) => true);


 String get currentEmail => _emailController.hasValue ? _emailController.value :"temp@gmail.com";


 void getData(){
   final email = _emailController.value;
   final password = _passwordController.value;
   final gender = _genderController.value;
   print("Email $email Password $password and Gender $gender");
 }

 Future submitData() async {
   final email = _emailController.value;
   final password = _passwordController.value;
   final gender = _genderController.value;
   final response = await api.signUp(email, password, gender);
   return response;
 }

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _genderController.close();
    _loadingController.close();
  }
}
