import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najot_pay/blocs/base/base_state.dart';
import 'package:najot_pay/data/models/card_model.dart';
import 'package:najot_pay/data/models/forms_status.dart';
import 'package:najot_pay/data/models/network_response.dart';
import 'package:najot_pay/data/repositories/cards_repository.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({required this.cardsRepository})
      : super(
          TransactionState(
            status: FormsStatus.pure,
            errorMessage: "",
            statusMessage: "",
            receiverCard: CardModel.initial(),
            senderCard: CardModel.initial(),
            amount: 0.0,
          ),
        ) {
    on<SetAmountEvent>(_setAmount);
    on<SetReceiverCardEvent>(_setReceiverCard);
    on<SetSenderCardEvent>(_setSenderCard);
    on<CheckValidationEvent>(_checkValidation);
    on<RunTransactionEvent>(_runTransaction);
    on<SetInitialEvent>(_setInitial);
  }

  final CardsRepository cardsRepository;

  _setAmount(SetAmountEvent event, emit) {
    emit(state.copyWith(amount: event.amount));
  }

  _setReceiverCard(SetReceiverCardEvent event, emit) {
    emit(state.copyWith(receiverCard: event.cardModel));
  }

  _setSenderCard(SetSenderCardEvent event, emit) {
    emit(state.copyWith(senderCard: event.cardModel));
  }

  _checkValidation(CheckValidationEvent event, emit) {

    debugPrint("RECEIVER CARD : ${state.receiverCard.cardNumber}");
    debugPrint("SENDER CARD : ${state.senderCard.cardNumber}");
    debugPrint("AMOUNT : ${state.amount}");

    if (state.amount < 1000 ||
        state.receiverCard.cardNumber.length != 16 ||
        state.senderCard.balance < 1000 ||
        state.senderCard.balance < state.amount) {
      emit(state.copyWith(statusMessage: "not_validated"));
      return;
    }
    emit(state.copyWith(statusMessage: "validated"));
    add(RunTransactionEvent());
  }

  _runTransaction(RunTransactionEvent event, emit) async {
    CardModel cardReceiver = state.receiverCard;
    CardModel cardSender = state.senderCard;

    cardSender =
        cardSender.copyWith(balance: cardSender.balance - state.amount);
    cardReceiver =
        cardReceiver.copyWith(balance: cardReceiver.balance + state.amount);

    bool isUpdated1 = await _updateCard(cardSender);
    bool isUpdated2 = await _updateCard(cardReceiver);

    if (isUpdated1 && isUpdated2) {
      emit(
        state.copyWith(
          statusMessage: "transaction_success",
          status: FormsStatus.success,
        ),
      );
    }
  }

  Future<bool> _updateCard(CardModel cardModel) async {
    NetworkResponse response = await cardsRepository.updateCard(cardModel);
    if (response.errorText.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  _setInitial(SetInitialEvent event, emit) {
    emit(
      TransactionState(
        status: FormsStatus.pure,
        errorMessage: "",
        statusMessage: "",
        receiverCard: CardModel.initial(),
        senderCard: CardModel.initial(),
        amount: 0.0,
      ),
    );
  }
}
