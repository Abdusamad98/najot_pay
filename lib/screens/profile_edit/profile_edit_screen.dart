import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/blocs/auth/auth_bloc.dart';
import 'package:najot_pay/blocs/user_profile/user_profile_bloc.dart';
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

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  late UserModel userModel;

  @override
  void initState() {
    userModel = context.read<UserProfileBloc>().state.userModel;
    fullNameController.text = userModel.fullName;
    phoneController.text = userModel.phoneNumber;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state.statusMessage == "profile_updated") {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 36.h),
                if (userModel.imageUrl.isEmpty)
                  const Icon(
                    Icons.person,
                    size: 100,
                  ),
                if (userModel.imageUrl.isNotEmpty)
                  Image.network(
                    userModel.imageUrl,
                    width: 100,
                  ),
                SizedBox(height: 30.h),
                Text(
                  "Profile",
                  style: AppTextStyle.interSemiBold.copyWith(fontSize: 22),
                ),
                TextFieldContainer(
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: SvgPicture.asset(AppImages.personIcon),
                  ),
                  hintText: "Full Name",
                  keyBoardType: TextInputType.text,
                  controller: fullNameController,
                ),
                TextFieldContainer(
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: SvgPicture.asset(
                      AppImages.phone,
                      colorFilter: const ColorFilter.mode(
                        AppColors.c_1317DD,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  hintText: "Phone",
                  keyBoardType: TextInputType.phone,
                  controller: phoneController,
                ),
                SizedBox(height: 22.h),
                MyCustomButton(
                  onTap: () {
                    if (isValidInputs()) {
                      userModel = userModel.copyWith(
                        lastname: fullNameController.text,
                        phoneNumber: phoneController.text,
                      );
                      context
                          .read<UserProfileBloc>()
                          .add(UpdateUserEvent(userModel));
                    } else {
                      showUniqueDialog(errorMessage: "Ma'lumotlar xato");
                      return;
                    }
                  },
                  readyToSubmit: isValidInputs(),
                  isLoading: state.status == FormsStatus.loading,
                  title: "Update",
                  color: AppColors.c_1317DD,
                  subColor: AppColors.c_C4C4C4,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }

  bool isValidInputs() =>
      AppConstants.textRegExp.hasMatch(fullNameController.text) &&
      AppConstants.phoneRegExp.hasMatch(phoneController.text);

  @override
  void dispose() {
    phoneController.dispose();
    fullNameController.dispose();
    super.dispose();
  }
}
