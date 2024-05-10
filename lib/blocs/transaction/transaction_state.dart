part of 'transaction_bloc.dart';

class TransactionState extends BaseState {
  const TransactionState({
    required super.status,
    required super.errorMessage,
    required super.statusMessage,
    required this.amount,
    required this.receiverCard,
    required this.senderCard,
  });

  final CardModel receiverCard;
  final CardModel senderCard;
  final double amount;

  TransactionState copyWith({
    CardModel? receiverCard,
    CardModel? senderCard,
    double? amount,
    FormsStatus? status,
    String? errorMessage,
    String? statusMessage,
  }) =>
      TransactionState(
        status: status ?? this.status,
        receiverCard: receiverCard ?? this.receiverCard,
        senderCard: senderCard ?? this.senderCard,
        amount: amount ?? this.amount,
        errorMessage: errorMessage ?? this.errorMessage,
        statusMessage: statusMessage ?? this.statusMessage,
      );

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        statusMessage,
        receiverCard,
        senderCard,
        amount,
      ];
}
