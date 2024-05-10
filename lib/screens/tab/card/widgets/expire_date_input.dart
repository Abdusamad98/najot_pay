import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/utils/colors/app_colors.dart';

class ExpireDateInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const ExpireDateInput({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  State<ExpireDateInput> createState() => _ExpireDateInputState();
}

class _ExpireDateInputState extends State<ExpireDateInput> {
  bool obscure = false;

  var maskFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    widget.controller.addListener(() {});

    super.initState();
  }

  _validateExpireDate(String dateText) {
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year % 100;

    List<String> list = dateText.split("/");
    int monthNumber = int.parse(list[0]); //1
    int yearNumber = int.parse(list[1]); //25

    if (monthNumber > 12) {
      widget.controller.clear();
      return;
    }

    if (yearNumber < currentYear) {
      widget.controller.clear();
      return;
    }

    if ((monthNumber < currentMonth) && (yearNumber == currentYear)) {
      widget.controller.clear();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          spreadRadius: 15,
          blurRadius: 10,
          offset: const Offset(10, 10),
        ),
      ]),
      // padding: EdgeInsets.symmetric(vertical: 5.w),
      child: TextField(
        obscureText: obscure,
        focusNode: widget.focusNode,
        controller: widget.controller,
        inputFormatters: [maskFormatter],
        onChanged: (v) {
          if (v.length == 5) {
            _validateExpireDate(v);
            widget.focusNode.unfocus();
          }
          setState(() {});
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    widget.controller.clear();
                  },
                  icon: const Icon(Icons.clear),
                )
              : null,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
          hintText: "Expire Date",
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
        keyboardType: TextInputType.number,
        // maxLines: ,
        textAlign: TextAlign.start,
      ),
    );
  }
}
