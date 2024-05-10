import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/data/models/card_model.dart';
import 'package:najot_pay/utils/images/app_images.dart';
import 'package:najot_pay/utils/styles/app_text_style.dart';

class CardItemView extends StatelessWidget {
  CardItemView({
    super.key,
    required this.cardModel,
    this.onTap,
  });

  final CardModel cardModel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Color(int.parse("0xff${cardModel.color}")),
              Color(int.parse("0xff${cardModel.color}")).withOpacity(0.5),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardModel.bank,
              style: AppTextStyle.interSemiBold.copyWith(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24.h),
            Image.asset(
              AppImages.chip,
              width: 56.w,
              height: 56.w,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maskFormatter.maskText(cardModel.cardNumber),
                        style: AppTextStyle.interSemiBold.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cardModel.expireDate,
                            style: AppTextStyle.interSemiBold.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        cardModel.cardHolder.toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.interSemiBold.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: cardModel.type == -1
                      ? Icon(
                          Icons.credit_card,
                          size: 56.w,
                        )
                      : Image.asset(
                          getIconPath(cardModel.type),
                          width: 56.w,
                          height: 56.w,
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String getIconPath(int type) {
    if (type == 1) {
      return AppImages.uzCard;
    }
    if (type == 2) {
      return AppImages.humo;
    }
    return AppImages.visa;
  }

  var maskFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}
