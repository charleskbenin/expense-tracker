import 'dart:math';

import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/core/constants/common.dart';
import 'package:expense_tracker/core/extensions/string_extension.dart';
import 'package:expense_tracker/core/extensions/widgets/padding_extension.dart';
import 'package:expense_tracker/core/extensions/widgets/text_extension.dart';
import 'package:expense_tracker/src/shared_widgets/common/app_list_tile.dart';
import 'package:expense_tracker/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/view_models/base_view.dart';
import '../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../shared_widgets/common/empty_state.dart';
import '../../../../shared_widgets/common/zloading.dart';
import '../../domain/expense_model.dart';
import '../view_model/expense_view_model.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ExpenseViewModel>().fetchUserExpenditure(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      hasLeading: false,
      title: "Expenditure",
      child: BaseView<ExpenseViewModel>(
        builder: (context, expenseConsumer, child) {
          if (expenseConsumer.getComponentLoading('fetchUserExpenditure') &&
              expenseConsumer.getUserExpenditure.isEmpty) {
            return const Center(
              child: ZLoading(),
            );
          }

          if (expenseConsumer.getUserExpenditure.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.20,
              ),
              child: const EmptyState(
                title: '',
                subtitle: 'No Expense yet',
              ),
            );
          }

          // Step 1: Group expenses by category
          final Map<String, List<ExpenseModel>> groupedExpenses = {};

          for (var expense in expenseConsumer.getUserExpenditure) {
            final category = expense.category?.toLowerCase() ?? 'Uncategorized';
            if (groupedExpenses.containsKey(category)) {
              groupedExpenses[category]!.add(expense);
            } else {
              groupedExpenses[category] = [expense];
            }
          }

          // Function to generate a random color
          Color generateRandomColor() {
            final Random random = Random();
            return Color.fromARGB(
              255, // Full opacity
              random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256),
            );
          }

          // Set to track used colors for this category
          final Set<Color> usedColors = {};

          return ListView.builder(
            itemCount: groupedExpenses.keys.length,
            itemBuilder: (context, index){
              final category = groupedExpenses.keys.elementAt(index);
              final expenses = groupedExpenses[category] ?? [];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VSpace(height: 20),
                  Text(category.toString().toUpperCase()).extraBold().fontSize(20).color(kPrimaryBlack).paddingSymmetric(horizontal: kWidthPadding),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: expenses.length,
                    itemBuilder: (context, expenseIndex) {
                      final expense = expenses[expenseIndex];
                      Color color;
                      do {
                        color = generateRandomColor();
                      } while (usedColors.contains(color));

                      usedColors.add(color);
                      return AppListTile(
                        title: Text(expense.nameOfItem.toString().toUpperKebabCase).bold().fontSize(16).color(kPrimaryBlack),
                        subtitle: Text('$kCurrency ${expense.estimatedAmount}'),
                        leading: CircleAvatar(
                          backgroundColor: color,
                          child: Text(
                            expense.nameOfItem?.substring(0, 1) ?? '',
                          ).bold().fontSize(24).color(kPrimaryWhite),
                        ),
                      ).paddingSymmetric(horizontal: kWidthPadding);
                    },
                  ),
                ],
              );
            }
          );
        },
      ),
    );
  }
}
