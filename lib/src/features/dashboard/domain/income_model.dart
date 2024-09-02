import 'dart:convert';

class IncomeModel {
  final String id;
  final String nameOfRevenue;
  final int amount;

  IncomeModel({
    required this.id,
    required this.nameOfRevenue,
    required this.amount,
  });

  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
      id: json['id'] as String,
      nameOfRevenue: json['nameOfRevenue'] as String,
      amount: _parseAmount(json['amount']),
    );
  }

  // Helper function to handle the parsing of amount field
  static int _parseAmount(dynamic amount) {
    if (amount is int) {
      return amount;
    } else if (amount is String) {
      return int.tryParse(amount) ?? 0;
    } else {
      return 0;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameOfRevenue': nameOfRevenue,
      'amount': amount,
    };
  }

  static String encode(List<IncomeModel> objects) => json.encode(
    objects.map<Map<String, dynamic>>((obj) => obj.toJson()).toList(),
  );

  static List<IncomeModel> decode(String objects) => objects.isEmpty
      ? []
      : (json.decode(objects) as List<dynamic>)
      .map<IncomeModel>((obj) => IncomeModel.fromJson(obj))
      .toList();
}

class IncomeList {
  IncomeList({required this.list});
  final List<IncomeModel> list;

  factory IncomeList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => IncomeModel.fromJson(obj)).toList();
    return IncomeList(list: list);
  }
}
