import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/auth/auth_bloc.dart';
import 'package:shaparak/bloc/auth/auth_event.dart';
import 'package:shaparak/bloc/auth/auth_state.dart';
import 'package:shaparak/constans/color.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController usernameController =
      TextEditingController(text: 'mirage');
  final TextEditingController passwordController =
      TextEditingController(text: '123456789');
  final TextEditingController passwordConfirmController =
      TextEditingController(text: '123456789');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/images/register.jpg',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نام کاربری :',
                        style: TextStyle(
                          fontFamily: 'dana',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: TextField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //pasword
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 24,
                        left: 24,
                        bottom: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'رمز عبور  :',
                            style: TextStyle(
                              fontFamily: 'dana',
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            color: Colors.grey[300],
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //pasword confirm
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 24,
                        left: 24,
                        bottom: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'تکرار رمز عبور  :',
                            style: TextStyle(
                              fontFamily: 'dana',
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            color: Colors.grey[300],
                            child: TextField(
                              controller: passwordConfirmController,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthInitState) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                fontFamily: 'dana',
                                fontSize: 20.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: CustomColors.blueIndicator,
                              minimumSize: const Size(200.0, 48.0),
                            ),
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                AuthRegisterRequestEvent(
                                    usernameController.text,
                                    passwordController.text,
                                    passwordConfirmController.text),
                              );
                            },
                            child: const Text(
                              'ثبت نام',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
