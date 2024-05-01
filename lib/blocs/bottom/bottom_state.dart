class ChangeIndexState {
  final int index;

  ChangeIndexState({required this.index});

  ChangeIndexState copyWith({
    int? index,
  }) =>
      ChangeIndexState(
        index: index ?? this.index,
      );
}
