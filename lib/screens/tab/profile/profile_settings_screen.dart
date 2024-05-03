import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/blocs/auth/auth_bloc.dart';
import 'package:najot_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:najot_pay/data/models/forms_status.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/screens/tab/profile/widgets/profile_name_container.dart';
import 'package:najot_pay/screens/tab/profile/widgets/profile_settings_button.dart';
import 'package:najot_pay/utils/styles/app_text_style.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  //TODO-2 UserProfileBloc ichidagi userni get qilishni bu yerdan olib tashlaymiz.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.editProfileRoute);
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 36.h),
                if (state.userModel.imageUrl.isEmpty)
                  const Icon(
                    Icons.person,
                    size: 100,
                  ),
                if (state.userModel.imageUrl.isNotEmpty)
                  Image.network(
                    state.userModel.imageUrl,
                    width: 100,
                  ),
                Text(
                  state.userModel.phoneNumber,
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 24.h),
                ProfileNameContainer(userModel: state.userModel),
                SizedBox(height: 8.h),
                ProfileSettingsButton(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.securityRoute);
                  },
                  icon: Icons.security,
                  title: "Security",
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.status == FormsStatus.unauthenticated) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteNames.authRoute,
                        (route) => false,
                      );
                    }
                  },
                  child: ProfileSettingsButton(
                    onTap: () {
                      context.read<AuthBloc>().add(LogOutUserEvent());
                    },
                    icon: Icons.logout,
                    title: "Logout",
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
