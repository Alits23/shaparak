import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaparak/bloc/auth/auth_bloc.dart';
import 'package:shaparak/bloc/auth/auth_event.dart';
import 'package:shaparak/bloc/auth/auth_state.dart';
import 'package:shaparak/constans/color.dart';
import 'package:shaparak/view/register_screen.dart';
import 'package:shaparak/widgets/bottom_navigation.dart';
import 'package:shaparak/widgets/cashed_image.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController usernameController =
      TextEditingController(text: 'alits23');
  final TextEditingController passwordController =
      TextEditingController(text: '123456789');
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: ViewContainer(
          usernameController: usernameController,
          passwordController: passwordController),
    );
  }
}

class ViewContainer extends StatelessWidget {
  const ViewContainer({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                const SizedBox(
                  width: 200,
                  height: 200,
                  child: CashedImage(
                    imageUrl:
                        'https://img.freepik.com/free-vector/contact-icon-3d-vector-illustration-blue-button-with-user-profile-symbol-networking-sites-apps-cartoon-style-isolated-white-background-online-communication-digital-marketing-concept_778687-1715.jpg?size=338&ext=jpg&ga=GA1.1.2116175301.1700611200&semt=ais',
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                const SizedBox(
                  height: 20.0,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthResponseState) {
                      state.response.fold((l) {}, (r) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const BottomNavigation(),
                        ));
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthInitState) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontFamily: 'dana',
                            fontSize: 20.0,
                          ),
                          backgroundColor: CustomColors.blueIndicator,
                          minimumSize: const Size(200.0, 48.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
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
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterScreen();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'ثبت نام',
                    style: TextStyle(
                      fontFamily: 'dana',
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
