import 'dart:convert';

class ExpenseModel {
  final String? id;
  final String? category;
  final String? nameOfItem;
  final int? estimatedAmount;

  ExpenseModel({
    required this.id,
    required this.category,
    required this.nameOfItem,
    required this.estimatedAmount,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as String,
      category: json['category'] as String,
      nameOfItem: json['nameOfItem'] as String,
      estimatedAmount: _parseAmount(json['estimatedAmount']),
    );
  }
//   // Helper function to handle the parsing of amount field
  static int _parseAmount(dynamic estimatedAmount) {
    if (estimatedAmount is int) {
      return estimatedAmount;
    } else if (estimatedAmount is String) {
      return int.tryParse(estimatedAmount) ?? 0;
    } else {
      return 0;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'nameOfItem': nameOfItem,
      'estimatedAmount': estimatedAmount,
    };
  }
//
  static String encode(List<ExpenseModel> objects) => json.encode(
    objects.map<Map<String, dynamic>>((obj) => obj.toJson()).toList(),
  );

  static List<ExpenseModel> decode(String objects) => objects.isEmpty
      ? []
      : (json.decode(objects) as List<dynamic>)
      .map<ExpenseModel>((obj) => ExpenseModel.fromJson(obj))
      .toList();

}

class ExpenseList {
  ExpenseList({required this.list});
  final List<ExpenseModel> list;

  factory ExpenseList.fromJson(List parsedJson) {
    final list = parsedJson.map((obj) => ExpenseModel.fromJson(obj) ).toList();
    return ExpenseList(list: list);
  }

}
