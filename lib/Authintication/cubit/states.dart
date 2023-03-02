import 'package:algad_infohub/Authintication/cubit/cubit.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginFailureState extends AuthStates {
  final String errorMessage;

  LoginFailureState(this.errorMessage);
}

class RegisterSuccessState extends AuthStates {}

class RegisterFailureState extends AuthStates {
  final String errorMessage;

  RegisterFailureState(this.errorMessage);
}

class ChangePasswordVisibilityState extends AuthStates {}