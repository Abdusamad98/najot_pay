class CardModel {
  final String cardHolder;
  final String cardNumber;
  final String expireDate;
  final String userId;
  final int type;
  final String cvc;
  final String icon;
  final double balance;
  final String bank;
  final String cardId;
  final String color;
  final bool isMain;

  CardModel({
    required this.icon,
    required this.balance,
    required this.cardHolder,
    required this.cardNumber,
    required this.cvc,
    required this.userId,
    required this.expireDate,
    required this.type,
    required this.bank,
    required this.cardId,
    required this.color,
    required this.isMain,
  });

  CardModel copyWith({
    String? cardHolder,
    String? cardNumber,
    String? expireDate,
    String? userId,
    int? type,
    String? cvc,
    String? icon,
    String? bank,
    double? balance,
    String? cardId,
    String? color,
    bool? isMain,
  }) {
    return CardModel(
      userId: userId ?? this.userId,
      cardHolder: cardHolder ?? this.cardHolder,
      expireDate: expireDate ?? this.expireDate,
      type: type ?? this.type,
      cvc: cvc ?? this.cvc,
      balance: balance ?? this.balance,
      icon: icon ?? this.icon,
      cardId: cardId ?? this.cardId,
      cardNumber: cardNumber ?? this.cardNumber,
      bank: bank ?? this.bank,
      color: color ?? this.color,
      isMain: isMain ?? this.isMain,
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "cardHolder": cardHolder,
        "expireDate": expireDate,
        "type": type,
        "cvc": cvc,
        "balance": balance,
        "icon": icon,
        "cardId": cardId,
        "cardNumber": cardNumber,
        "bank": bank,
        "color": color,
        "isMain": isMain,
      };

  Map<String, dynamic> toJsonForUpdate() => {
        "balance": balance,
        "isMain": isMain,
        "color": color,
      };

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      userId: json["userId"] as String? ?? "",
      cardHolder: json["cardHolder"] as String? ?? "",
      expireDate: json["expireDate"] as String? ?? "",
      type: json["type"] as int? ?? 0,
      cvc: json["cvc"] as String? ?? "",
      balance: (json["balance"] as num? ?? 0).toDouble(),
      icon: json["icon"] as String? ?? "",
      cardId: json["cardId"] as String? ?? "",
      cardNumber: json["cardNumber"] as String? ?? "",
      bank: json["bank"] as String? ?? "",
      color: json["color"] as String? ?? "",
      isMain: json["isMain"] as bool? ?? false,
    );
  }

  static CardModel initial() => CardModel(
        icon: "",
        balance: 0,
        cardHolder: "",
        cardNumber: "",
        cvc: "",
        userId: "",
        expireDate: "",
        type: -1,
        bank: "",
        cardId: "",
        color: "000000",
        isMain: false,
      );
}
