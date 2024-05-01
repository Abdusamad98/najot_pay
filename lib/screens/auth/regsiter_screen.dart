import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/blocs/auth/auth_bloc.dart';
import 'package:najot_pay/data/models/forms_status.dart';
import 'package:najot_pay/data/models/user_model.dart';
import 'package:najot_pay/screens/auth/widgets/my_custom_button.dart';
import 'package:najot_pay/screens/dialogs/unical_dialog.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/screens/widgets/auth_item.dart';
import 'package:najot_pay/screens/widgets/text_container.dart';
import 'package:najot_pay/utils/colors/app_colors.dart';
import 'package:najot_pay/utils/constants/app_constants.dart';
import 'package:najot_pay/utils/images/app_images.dart';
import 'package:najot_pay/utils/styles/app_text_style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController gmailController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 36.h),
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
                          style:
                              AppTextStyle.interSemiBold.copyWith(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                  TextFieldContainer(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: SvgPicture.asset(AppImages.personIcon),
                    ),
                    hintText: "First Name",
                    keyBoardType: TextInputType.text,
                    controller: usernameController,
                  ),
                  TextFieldContainer(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: SvgPicture.asset(AppImages.personIcon),
                    ),
                    hintText: "Last Name",
                    keyBoardType: TextInputType.text,
                    controller: lastnameController,
                  ),
                  TextFieldContainer(
                    regExp: AppConstants.emailRegExp,
                    errorText: "Email format not supported",
                    prefixIcon: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
                      child: SvgPicture.asset(AppImages.emailIcon),
                    ),
                    hintText: "Email",
                    keyBoardType: TextInputType.emailAddress,
                    controller: gmailController,
                  ),
                  TextFieldContainer(
                    regExp: AppConstants.passwordRegExp,
                    errorText:
                        "Parolda 8 belgidan va 1 katta harfdan iborat bo'lishi kerak !",
                    isObscureText: true,
                    prefixIcon: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                      child: SvgPicture.asset(AppImages.lockIcon),
                    ),
                    hintText: "Password",
                    keyBoardType: TextInputType.text,
                    controller: passwordController,
                  ),
                  TextFieldContainer(
                    regExp: AppConstants.passwordRegExp,
                    errorText:
                        "Parolda 8 belgidan va 1 katta harfdan iborat bo'lishi kerak !",
                    isObscureText: true,
                    prefixIcon: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                      child: SvgPicture.asset(AppImages.lockIcon),
                    ),
                    hintText: "Confirm Password",
                    keyBoardType: TextInputType.text,
                    controller: confirmPasswordController,
                  ),
                  SizedBox(height: 22.h),
                  MyCustomButton(
                    onTap: () {
                      context.read<AuthBloc>().add(IsValidToInsert(
                            passwordController: passwordController.text,
                            usernameController: usernameController.text,
                            gmailController: gmailController.text,
                            lastnameController: lastnameController.text,
                            phoneController: phoneController.text,
                            confirmPasswordController:
                                confirmPasswordController.text,
                          ));
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        context.read<AuthBloc>().add(
                              RegisterUserEvent(
                                userModel: UserModel(
                                  password: passwordController.text,
                                  email: gmailController.text,
                                  imageUrl: "",
                                  lastname: lastnameController.text,
                                  phoneNumber: phoneController.text.trim(),
                                  userId: "",
                                  username: usernameController.text,
                                ),
                              ),
                            );
                      } else {
                        showUniqueDialog(errorMessage: "Parrolar mos emas");
                        return;
                      }
                    },
                    readyToSubmit: true,
                    isLoading: state.status == FormsStatus.loading,
                    title: "Register",
                    color: AppColors.c_1317DD,
                    subColor: AppColors.c_C4C4C4,
                  ),
                  SizedBox(height: 20.h),
                  const AuthItem(
                    title: "Already have an account?",
                    subtitle: "Login",
                    routeName: RouteNames.authRoute,
                    color: AppColors.black,
                    subColor: AppColors.c_1317DD,
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.status == FormsStatus.error) {
            showUniqueDialog(errorMessage: state.errorMessage);
          }
          if (state.isError) {
            showUniqueDialog(errorMessage: state.errorMessage);
          }
          if (state.status == FormsStatus.authenticated) {
            Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
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
