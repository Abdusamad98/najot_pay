import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najot_pay/blocs/card/user_cards_bloc.dart';
import 'package:najot_pay/blocs/card/user_cards_event.dart';
import 'package:najot_pay/blocs/card/user_cards_state.dart';
import 'package:najot_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:najot_pay/data/models/card_model.dart';
import 'package:najot_pay/data/models/forms_status.dart';
import 'package:najot_pay/screens/widgets/my_custom_button.dart';
import 'package:najot_pay/screens/widgets/text_container.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {


  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController expireDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCardsBloc, UserCardsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                TextFieldContainer(
                  hintText: "Card number",
                  keyBoardType: TextInputType.number,
                  controller: cardNumber,
                ),
                TextFieldContainer(
                  hintText: "Expire Date",
                  keyBoardType: TextInputType.number,
                  controller: expireDate,
                ),
                MyCustomButton(
                  onTap: () {
                    List<CardModel> db = state.cardsDB;
                    List<CardModel> myCards = state.userCards;

                    bool isExist = false;

                    for (var element in myCards) {
                      if (element.cardNumber == cardNumber.text) {
                        isExist = true;
                        break;
                      }
                    }

                    CardModel? cardModel;
                    bool hasInDB = false;
                    for (var element in db) {
                      if (element.cardNumber == cardNumber.text) {
                        hasInDB = true;
                        cardModel = element;
                        break;
                      }
                    }

                    if ((!isExist) && hasInDB) {
                      context
                          .read<UserCardsBloc>()
                          .add(AddCardEvent(cardModel!));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Karta qo'shilgan yoki bazada mavjud emas!"),
                        ),
                      );
                    }
                  },
                  title: "Add Card",
                  isLoading: state.status == FormsStatus.loading,
                )
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state.statusMessage == "added") {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
