import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/blocs/auth/auth_bloc.dart';
import 'package:najot_pay/data/models/forms_status.dart';
import 'package:najot_pay/data/models/user_model.dart';
import 'package:najot_pay/screens/widgets/my_custom_button.dart';
import 'package:najot_pay/screens/dialogs/unical_dialog.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/screens/auth/widgets/auth_item.dart';
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
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
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
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: SvgPicture.asset(AppImages.personIcon),
                  ),
                  hintText: "Phone",
                  keyBoardType: TextInputType.phone,
                  controller: phoneController,
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
                  controller: passwordController1,
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
                  controller: passwordController2,
                ),
                SizedBox(height: 22.h),
                MyCustomButton(
                  onTap: () {
                    if (isValidRegisterCredentials()) {
                      context.read<AuthBloc>().add(
                            RegisterUserEvent(
                              userModel: UserModel(
                                password: passwordController1.text,
                                email:
                                    "${usernameController.text.toLowerCase()}@gmail.com",
                                imageUrl: "",
                                fullName: lastnameController.text,
                                phoneNumber: phoneController.text.trim(),
                                userId: "",
                                username: usernameController.text,
                                fcm: "",
                                authUid: "",
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
                AuthItem(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: "",
                  subtitle: "Login now",
                  color: AppColors.c_1317DD,
                  subColor: AppColors.c_1317DD,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool isValidRegisterCredentials() =>
      AppConstants.passwordRegExp.hasMatch(passwordController1.text) &&
      AppConstants.textRegExp.hasMatch(usernameController.text) &&
      AppConstants.textRegExp.hasMatch(lastnameController.text) &&
      AppConstants.phoneRegExp.hasMatch(phoneController.text) &&
      (passwordController1.text == passwordController2.text);

  @override
  void dispose() {
    passwordController1.dispose();
    usernameController.dispose();
    phoneController.dispose();
    lastnameController.dispose();
    super.dispose();
  }
}
