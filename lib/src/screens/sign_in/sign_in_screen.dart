// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/bottom_navigation.dart';
import 'package:task_1/src/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:task_1/src/screens/sign_in/bloc/sign_in_event.dart';
import 'package:task_1/src/screens/sign_in/bloc/sign_in_state.dart';
import 'package:task_1/src/screens/sign_up/bloc/sign_up_bloc.dart';

import '../sign_up/sign_up_screen.dart';
import '../forgot_password/forgot_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: const SignInWidget(),
    );
  }
}

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInWidget> {
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _pwd = TextEditingController();

  bool passwordVisible = false;

  @override
  void initState() {
    passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SignInBloc, SignInState>(listener: (context, state) {
        if (state is SignInLoadedState) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomNavigation(),
            ),
            (route) => false,
          );
        } else if (state is SignInErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      }, builder: (context, state) {
        if (state is SignInLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SignInInvalidCredentials) {
          return const SignInScreen();
        }
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Image.asset(
                      'assets/img/Signin.png',
                      height: 250,
                      width: 250,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'SIGN IN',
                      style: TextStyle(
                        color: Color.fromARGB(255, 53, 86, 217),
                        fontSize: 29,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _phone,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        isDense: true,
                        labelText: 'Phone Number',
                        prefixIcon: const Icon(
                          Icons.phone,
                          size: 25,
                        ),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? const Color.fromARGB(255, 53, 86, 217)
                                : Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black45),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 53, 86, 217)),
                        ),
                        labelStyle: const TextStyle(color: Colors.black45),
                        hintText: 'Enter Phone Number here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      controller: _pwd,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(10),
                        labelText: 'Password',
                        prefixIcon: const Icon(
                          Icons.security,
                          size: 25,
                        ),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? const Color.fromARGB(255, 53, 86, 217)
                                : Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black45),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 53, 86, 217)),
                        ),
                        labelStyle: const TextStyle(color: Colors.black45),
                        hintText: 'Enter password here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color.fromARGB(255, 53, 86, 217),
                          ),
                        ),
                      ),
                      obscureText: passwordVisible,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      const ForgotPasswordScreen()),
                            );
                          },
                          child: const Text(
                            'Forgot Password ?',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<SignInBloc>(context).add(
                          SignInBtnEvent(
                            email: _phone.text,
                            password: _pwd.text,
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 41,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 50, 82, 223),
                            Color.fromARGB(255, 53, 86, 217),
                          ]),
                        ),
                        child: const Center(
                          child: Text(
                            'GET OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "If you don't have Account? ",
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BlocProvider<SignUpBloc>(
                                    create: (context) => SignUpBloc(),
                                    child: const SignUpScreen(),
                                  ),
                                ),
                                (route) => false);
                          },
                          child: const Text(
                            'SignUp',
                            style: TextStyle(
                              color: Color.fromARGB(255, 53, 86, 217),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
