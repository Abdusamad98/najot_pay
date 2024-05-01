import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/blocs/auth/auth_bloc.dart';
import 'package:najot_pay/data/models/forms_status.dart';
import 'package:najot_pay/data/models/user_model.dart';
import 'package:najot_pay/screens/auth/widgets/my_custom_button.dart';
import 'package:najot_pay/utils/constants/app_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isValidLoginCredentials() {
    return AppConstants.passwordRegExp.hasMatch(passwordController.text) &&
        AppConstants.textRegExp.hasMatch(usernameController.text) &&
        AppConstants.phoneRegExp.hasMatch(phoneController.text) &&
        AppConstants.textRegExp.hasMatch(lastnameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Screen"),
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
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: phoneController,
                        onChanged: (v) {
                          setState(() {});
                        },
                        validator: (v) {
                          if (v != null &&
                              AppConstants.phoneRegExp.hasMatch(v)) {
                            return null;
                          }
                          return "Phone error";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          hintText: "PHONE",
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: lastnameController,
                        onChanged: (v) {
                          setState(() {});
                        },
                        validator: (v) {
                          if (v != null &&
                              AppConstants.textRegExp.hasMatch(v)) {
                            return null;
                          }
                          return "Lastname error";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          hintText: "LASTNAME",
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 120.h),
                    ],
                  ),
                ),
                SizedBox(height: 120.h),
                MyCustomButton(
                  onTap: () {
                    context.read<AuthBloc>().add(
                          RegisterUserEvent(
                            userModel: UserModel(
                              password: passwordController.text,
                              email:
                                  "${usernameController.text}@gmail.com".trim(),
                              imageUrl: "",
                              lastname: lastnameController.text,
                              phoneNumber: phoneController.text.trim(),
                              userId: "",
                              username: usernameController.text,
                            ),
                          ),
                        );
                  },
                  readyToSubmit: isValidLoginCredentials(),
                  isLoading: state.status == FormsStatus.loading,
                  title: "Register",
                ),
                SizedBox(height: 20.h),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Login"))
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state.status == FormsStatus.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    lastnameController.dispose();
    super.dispose();
  }
}
