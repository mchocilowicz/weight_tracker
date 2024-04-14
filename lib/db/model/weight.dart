class Weight {
  final int id;
  final double amount;
  final DateTime createdAt;

  Weight({required this.id, required this.amount, required this.createdAt});

  static Weight fromMap(Map<String, Object?> row) => Weight(
      id: row['id'] as int,
      amount: row['amount'] as double,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['createdAt'] as int));
}
