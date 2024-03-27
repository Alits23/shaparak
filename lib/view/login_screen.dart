import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/auth/auth_bloc.dart';
import 'package:shaparak/bloc/auth/auth_event.dart';
import 'package:shaparak/bloc/auth/auth_state.dart';
import 'package:shaparak/constans/color.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController usernameController =
      TextEditingController(text: 'alits23');
  final TextEditingController passwordController =
      TextEditingController(text: '123456789');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.blue,
      body: SafeArea(child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/icon_application.png',
                          width: 100.0,
                          height: 100.0,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'شاپرک شاپ',
                          style: TextStyle(
                            fontFamily: 'sb',
                            fontSize: 24.0,
                            color: CustomColors.backgroundScreenColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: CustomColors.blue,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: CustomColors.backgroundScreenColor,
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'نام کابری',
                          labelStyle: const TextStyle(
                            fontFamily: 'sm',
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                          // focusedBorder
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 3.0,
                              color: CustomColors.blueIndicator,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          // enabledBorder
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2.0,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // password
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          // focusedBorder
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 3.0,
                              color: CustomColors.blueIndicator,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'رمز عبور',
                          labelStyle: const TextStyle(
                            fontFamily: 'sm',
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                          // enabledBorder
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2.0,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthInitState) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                  fontFamily: 'sb',
                                  fontSize: 20.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                backgroundColor: CustomColors.blueIndicator,
                                minimumSize: const Size(200.0, 48.0),
                              ),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                  AuthLoginRequestEvent(
                                    usernameController.text,
                                    passwordController.text,
                                  ),
                                );
                              },
                              child: const Text(
                                'ورود',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                          if (state is AuthLoadingState) {
                            return const CircularProgressIndicator(
                              color: CustomColors.blueIndicator,
                            );
                          }
                          if (state is AuthResponseState) {
                            Text text = const Text('');
                            state.response.fold(
                              (l) {
                                text = Text(l);
                              },
                              (r) {
                                text = Text(r);
                              },
                            );
                            return text;
                          }
                          return const Text('! خطای نا مشخص');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
