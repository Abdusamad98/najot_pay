import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/blocs/auth/auth_bloc.dart';
import 'package:najot_pay/data/models/forms_status.dart';
import 'package:najot_pay/screens/auth/widgets/my_custom_button.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/utils/constants/app_constants.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool isValidLoginCredentials() =>
      AppConstants.passwordRegExp.hasMatch(passwordController.text) &&
      AppConstants.textRegExp.hasMatch(usernameController.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auth Screen"),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: usernameController,
                        onChanged: (v) {
                          setState(() {});
                        },
                        validator: (v) {
                          if (v != null &&
                              AppConstants.textRegExp.hasMatch(v)) {
                            return null;
                          }
                          return "Username error";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                            hintText: "USERNAME",
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ))),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: passwordController,
                        onChanged: (v) {
                          setState(() {});
                        },
                        validator: (v) {
                          if (v != null &&
                              AppConstants.passwordRegExp.hasMatch(v)) {
                            return null;
                          }
                          return "Password error";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                            hintText: "PASSWORD",
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ))),
                      ),
                      SizedBox(height: 120.h),
                      IconButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(SignInWithGoogleEvent());
                        },
                        icon: const Icon(Icons.login),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 120.h),
                MyCustomButton(
                  onTap: () {
                    context.read<AuthBloc>().add(LoginUserEvent(
                          username: usernameController.text,
                          password: passwordController.text,
                        ));
                  },
                  readyToSubmit: isValidLoginCredentials(),
                  isLoading: state.status == FormsStatus.loading,
                  title: "Login",
                ),
                SizedBox(height: 20.h),
                MyCustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.registerRoute);
                  },
                  title: "Register",
                )
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state.status == FormsStatus.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
          if (state.status == FormsStatus.authenticated) {
            if (state.statusMessage == "registered") {
              // state.userModel
              //TODO User ma'lumotlarini saqlansin
            }
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.tabRoute, (route) => false);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }
}
