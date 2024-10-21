abstract class AuthStates{}

class AuthInitialState extends AuthStates{}

class RegisterLoadingState extends AuthStates{}
class RegisterSuccessState extends AuthStates{}
class FailedToRegisterState extends AuthStates{
  final String message;
  FailedToRegisterState({required this.message});
}
class LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates{
  final String uId;

  LoginSuccessState(this.uId);
}
class FailedToLoginState extends AuthStates{
  final String message;
  FailedToLoginState({required this.message});
}
class CreateUserLoadingState extends AuthStates{}
class CreateUserSuccessState extends AuthStates{}
class FailedToCreateUserState extends AuthStates{
  final String message;
  FailedToCreateUserState({required this.message});
}



