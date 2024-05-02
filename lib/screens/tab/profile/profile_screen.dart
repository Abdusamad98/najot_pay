import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najot_pay/blocs/auth/auth_bloc.dart';
import 'package:najot_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:najot_pay/data/models/forms_status.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/utils/styles/app_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //TODO-2 UserProfileBloc ichidagi userni get qilishni bu yerdan olib tashlaymiz.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  state.userModel.email,
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 24,
                  ),
                ),
                Text(
                  state.userModel.username,
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 24,
                  ),
                ),
                Text(
                  state.userModel.lastname,
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 24,
                  ),
                ),
                Text(
                  state.userModel.phoneNumber,
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 24,
                  ),
                ),
                Text(
                  " USER ID :${state.userModel.userId}",
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 24,
                  ),
                ),
                Text(
                  " UID  :${state.userModel.authUid}",
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 24,
                  ),
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
                  child: TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LogOutUserEvent());
                    },
                    child: Text(
                      " LOGOUT",
                      style: AppTextStyle.interSemiBold.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
