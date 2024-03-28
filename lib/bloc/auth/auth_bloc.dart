import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/auth/auth_event.dart';
import 'package:shaparak/bloc/auth/auth_state.dart';
import 'package:shaparak/data/repository/authentication_repository.dart';
import 'package:shaparak/di/di.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository = locator.get();
  AuthBloc() : super(AuthInitState()) {
    on<AuthLoginRequestEvent>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.login(event.username, event.password);
      emit(AuthResponseState(response));
    });

    on<AuthRegisterRequestEvent>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.register(
        event.username,
        event.password,
        event.passwordConfirm,
      );
      emit(AuthResponseState(response));
    });
  }
}
