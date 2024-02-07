import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/sign_in/sign_in_screen.dart';
import 'package:task_1/src/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:task_1/src/screens/sign_up/bloc/sign_up_event.dart';
import 'package:task_1/src/screens/sign_up/bloc/sign_up_state.dart';

import '../bottom_navigation_bar.dart/bottom_navigation.dart';
import '../sign_in/bloc/sign_in_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final TextEditingController _cnfpwd = TextEditingController();

  bool passwordVisible = false;
  bool visiblePassword = false;
  @override
  void initState() {
    passwordVisible = true;
    visiblePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoadedState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const BottomNavigation(
                      // selectedIndex: 0,
                      ),
                ),
                (route) => false);
          } else if (state is SignUpErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SignUpLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SignUpInvalidCredentials) {
            return const SignUpScreen();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      'CREATE  AN  ACCOUNT',
                      style: TextStyle(
                        color: Color.fromARGB(255, 53, 86, 217),
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    TextFormField(
                      controller: _name,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(10),
                        labelText: 'Name',
                        prefixIcon: const Icon(
                          Icons.person,
                          size: 25,
                        ),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? const Color.fromARGB(255, 53, 86, 217)
                                : Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black45),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 53, 86, 217)),
                        ),
                        labelStyle: const TextStyle(color: Colors.black45),
                        hintText: 'Enter name here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _phone,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(10),
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
                            borderSide:
                                const BorderSide(color: Colors.black45),
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
                      height: 25,
                    ),
                    TextFormField(
                      controller: _email,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(10),
                        labelText: 'Email',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          size: 25,
                        ),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? const Color.fromARGB(255, 53, 86, 217)
                                : Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black45),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 53, 86, 217)),
                        ),
                        labelStyle: const TextStyle(color: Colors.black45),
                        hintText: 'Enter email here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
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
                            borderSide:
                                const BorderSide(color: Colors.black45),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 53, 86, 217)),
                        ),
                        labelStyle: const TextStyle(color: Colors.black45),
                        hintText: 'Enter password here',
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
                      height: 25,
                    ),
                    TextFormField(
                      controller: _cnfpwd,
                      autofocus: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(10),
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(
                          Icons.security,
                          size: 25,
                        ),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? const Color.fromARGB(255, 53, 86, 217)
                                : Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black45),
                            borderRadius: BorderRadius.circular(25)),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 53, 86, 217)),
                        ),
                        labelStyle: const TextStyle(color: Colors.black45),
                        hintText: 'Enter Confirm Password here',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visiblePassword = !visiblePassword;
                            });
                          },
                          icon: Icon(
                            visiblePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color.fromARGB(255, 53, 86, 217),
                          ),
                        ),
                      ),
                      obscureText: visiblePassword,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<SignUpBloc>(context).add(
                          SignUpBtnEvent(
                              name: _name.text,
                              email: _email.text,
                              mobileNo: _phone.text,
                              password: _pwd.text,
                              confirmPassword: _cnfpwd.text),
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
                            'REGISTER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an Account? ",
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
                                      BlocProvider<SignInBloc>(
                                    create: (context) => SignInBloc(),
                                    child: const SignInScreen(),
                                  ),
                                ),
                                (route) => false);
                          },
                          child: const Text(
                            'Sign In',
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
          );
        },
      ),
    );
  }
}
