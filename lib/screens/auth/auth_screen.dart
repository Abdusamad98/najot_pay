import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/blocs/auth/auth_bloc.dart';
import 'package:najot_pay/data/models/forms_status.dart';
import 'package:najot_pay/screens/auth/widgets/my_custom_button.dart';
import 'package:najot_pay/screens/dialogs/unical_dialog.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/screens/widgets/auth_item.dart';
import 'package:najot_pay/screens/widgets/text_container.dart';
import 'package:najot_pay/utils/colors/app_colors.dart';
import 'package:najot_pay/utils/constants/app_constants.dart';
import 'package:najot_pay/utils/images/app_images.dart';
import 'package:najot_pay/utils/styles/app_text_style.dart';

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
      AppConstants.emailRegExp.hasMatch(usernameController.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_1317DD,
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 56.h),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.loginImage,
                          height: 180.h,
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          "Sign Up",
                          style: AppTextStyle.interSemiBold
                              .copyWith(fontSize: 22, color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFieldContainer(
                    regExp: AppConstants.emailRegExp,
                    errorText: "Email format not supported",
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: SvgPicture.asset(AppImages.personIcon),
                    ),
                    hintText: "Email",
                    keyBoardType: TextInputType.emailAddress,
                    controller: usernameController,
                  ),
                  TextFieldContainer(
                    isObscureText: true,
                    regExp: AppConstants.passwordRegExp,
                    errorText:
                        "Parolda 8 belgidan va 1 katta harfdan iborat bo'lishi kerak !",
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: SvgPicture.asset(AppImages.lockIcon),
                    ),
                    hintText: "Password",
                    keyBoardType: TextInputType.text,
                    controller: passwordController,
                  ),
                  SizedBox(height: 55.h),
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
                  SizedBox(height: 16.h),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Or",
                          style: AppTextStyle.interRegular
                              .copyWith(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Log in with",
                          style: AppTextStyle.interRegular
                              .copyWith(fontSize: 14, color: Colors.white),
                        ),
                        SizedBox(height: 20.h),
                        IconButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(SignInWithGoogleEvent());
                          },
                          icon: SvgPicture.asset(AppImages.googleIcon),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const AuthItem(
                    title: "Don’t have an account?",
                    subtitle: "Register now",
                    routeName: RouteNames.registerRoute,
                    color: Colors.grey,
                    subColor: AppColors.white,
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.status == FormsStatus.error) {
            showUnicalDialog(errorMessage: state.errorMessage);
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
