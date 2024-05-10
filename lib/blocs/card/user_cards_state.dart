import 'package:equatable/equatable.dart';
import 'package:najot_pay/data/models/forms_status.dart';

import '../../data/models/card_model.dart';

class UserCardsState extends Equatable {
  final List<CardModel> userCards;
  final List<CardModel> cardsDB;
  final List<CardModel> activeCards;
  final FormsStatus status;
  final String errorMessage;
  final String statusMessage;

  const UserCardsState({
    required this.status,
    required this.userCards,
    required this.errorMessage,
    required this.statusMessage,
    required this.cardsDB,
    required this.activeCards,
  });

  UserCardsState copyWith({
    List<CardModel>? userCards,
    List<CardModel>? cardsDB,
    List<CardModel>? activeCards,
    FormsStatus? status,
    String? errorMessage,
    String? statusMessage,
  }) {
    return UserCardsState(
      userCards: userCards ?? this.userCards,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
      cardsDB: cardsDB ?? this.cardsDB,
      activeCards: activeCards ?? this.activeCards,
    );
  }

  @override
  List<Object?> get props => [
        status,
        userCards,
        errorMessage,
        statusMessage,
        cardsDB,
        activeCards,
      ];
}
