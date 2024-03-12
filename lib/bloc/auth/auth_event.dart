abstract class AuthEvent {}

class AuthLoginRequestEvent extends AuthEvent {
  String username;
  String password;
  AuthLoginRequestEvent(this.username, this.password);
}
