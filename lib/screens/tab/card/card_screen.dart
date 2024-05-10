import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najot_pay/blocs/card/user_cards_bloc.dart';
import 'package:najot_pay/blocs/card/user_cards_event.dart';
import 'package:najot_pay/blocs/card/user_cards_state.dart';
import 'package:najot_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:najot_pay/data/models/card_model.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/screens/tab/card/widgets/card_item_view.dart';
import 'package:najot_pay/utils/styles/app_text_style.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    context.read<UserCardsBloc>().add(GetCardsByUserId(
        userId: context.read<UserProfileBloc>().state.userModel.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cards",
          style: AppTextStyle.interSemiBold.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.addCardRoute);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: BlocBuilder<UserCardsBloc, UserCardsState>(
        builder: (context, state) {
          return ListView(
            children: List.generate(state.userCards.length, (index) {
              CardModel cardModel = state.userCards[index];
              return CardItemView(cardModel: cardModel);
            }),
          );
        },
      ),
    );
  }
}
