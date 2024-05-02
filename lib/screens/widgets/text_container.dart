import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/utils/colors/app_colors.dart';

class TextFieldContainer extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final RegExp? regExp;
  final String errorText;
  final TextInputType keyBoardType;
  final Widget? suffixIcon;
  final bool isObscureText;
  final FocusNode? focusNode;
  final Widget? prefixIcon;

  const TextFieldContainer({
    super.key,
    this.hintText = '',
    required this.keyBoardType,
    required this.controller,
    this.suffixIcon = const SizedBox(),
    this.isObscureText = false,
    this.focusNode,
    this.regExp,
    this.prefixIcon,
    this.errorText = '',
  });

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ]
      ),
      // padding: EdgeInsets.symmetric(vertical: 5.w),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.regExp != null
            ? (v) {
                if (v != null && widget.regExp!.hasMatch(v)) {
                  return null;
                } else {
                  return widget.errorText;
                }
              }
            : null,
        obscureText: obscure,
        focusNode: widget.focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isObscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  icon: Icon(
                      obscure ? CupertinoIcons.eye : CupertinoIcons.eye_slash),
                )
              : widget.suffixIcon,
          hintStyle: const TextStyle(color: AppColors.black, fontSize: 14),
          border: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: Colors.red),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: Colors.red),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        keyboardType: widget.keyBoardType,
        // maxLines: ,
        textAlign: TextAlign.start,
      ),
    );
  }
}
