abstract class AuthEvent {}

class AuthLoginRequestEvent extends AuthEvent {
  String username;
  String password;
  AuthLoginRequestEvent(this.username, this.password);
}

class AuthRegisterRequestEvent extends AuthEvent {
  String username;
  String password;
  String passwordConfirm;
  AuthRegisterRequestEvent(this.username, this.password, this.passwordConfirm);
}
