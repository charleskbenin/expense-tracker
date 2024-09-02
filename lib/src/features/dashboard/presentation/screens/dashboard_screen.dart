import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/core/extensions/string_extension.dart';
import 'package:expense_tracker/core/extensions/widgets/text_extension.dart';
import 'package:expense_tracker/core/utils/app_theme_util.dart';
import 'package:expense_tracker/src/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:expense_tracker/src/features/expense/presentation/view_model/expense_view_model.dart';
import 'package:expense_tracker/src/shared_widgets/cards/app_card.dart';
import 'package:expense_tracker/src/shared_widgets/common/app_list_tile.dart';
import 'package:expense_tracker/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/common.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/view_models/base_view2.dart';
import '../../../../shared_widgets/base/app_screen_scaffold.dart';
import '../../../../shared_widgets/common/empty_state.dart';
import '../../../../shared_widgets/common/zloading.dart';
import '../../../../shared_widgets/modals/add_expenditure_or_income_modal.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final dataMap = <String, double>{
    "Expenditure": 5,
    "Income": 6,
  };

  final colorList = <Color>[
    Colors.greenAccent,
    Colors.blue,
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        context.read<DashboardViewModel>().fetchUserIncome(context),
        context.read<ExpenseViewModel>().fetchUserExpenditure(context),
      ]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppDialogUtil.showScrollableBottomSheet(
            context: context,
            builder: (context) => const AddIncomeOrExpenditureModal(),
          );
        },
        backgroundColor: kBlue800,
        child: Icon(
          Icons.add,
          size: AppThemeUtil.radius(24),
        ),
      ),
      hasLeading: false,
      child: BaseView2<DashboardViewModel, ExpenseViewModel>(
        builder: (context, dashboardConsumer, expenseConsumer, child) {
          if (expenseConsumer.getComponentLoading('fetchUserExpenditure') &&
              expenseConsumer.getUserExpenditure.isEmpty &&
              (dashboardConsumer.getComponentLoading("fetchUserIncome") &&
                  dashboardConsumer.getUserIncome.isEmpty)) {
            return const Center(
              child: ZLoading(),
            );
          }

          if (expenseConsumer.getUserExpenditure.isEmpty &&
              dashboardConsumer.getUserIncome.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.20,
              ),
              child: const EmptyState(
                title: '',
                subtitle: 'All set, please add your Income and Expenditure',
              ),
            );
          }

          final int totalIncomeInt = dashboardConsumer.getUserIncome.fold<int>(
            0,
            (previousValue, element) => previousValue + element.amount,
          );

          final int totalExpenditureInt =
              expenseConsumer.getUserExpenditure.fold<int>(
            0,
            (previousValue, element) {
              final int estimatedAmount = (element.estimatedAmount != null &&
                      element.estimatedAmount != 0)
                  ? element.estimatedAmount ?? 0
                  : 0;
              return previousValue + estimatedAmount;
            },
          );

          // Calculate additional income needed
          double additionalIncomeNeeded =
              totalExpenditureInt.toDouble() - totalIncomeInt.toDouble();

          Map<String, double> dataMap = {
            "Income": totalIncomeInt.toDouble(),
            "Expenditure": totalExpenditureInt.toDouble(),
          };
          if (additionalIncomeNeeded > 0) {
            dataMap["Earn More"] = additionalIncomeNeeded;
          }
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: kWidthPadding),
            children: [
              const VSpace(height: 20),
              PieChart(
                dataMap: dataMap,
                chartType: ChartType.ring,
                baseChartColor: Colors.grey.withOpacity(0.2),
                colorList: const [kSuccess600, kError700, kGrey500],
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: false,
                ),
                totalValue: dataMap.values.reduce((a, b) => a + b),
              ),
              const VSpace(height: 30),
              if (additionalIncomeNeeded > 0) ...[
                AppCard(
                  decoration: BoxDecoration(color: kGrey100, borderRadius: BorderRadius.circular(AppThemeUtil.radius(10),),),
                  padding: EdgeInsets.all(AppThemeUtil.radius(10)),
                  child: Text(
                    "Your spending is outpacing your income! 🏆 You need to increase your earnings by $kCurrency${additionalIncomeNeeded.toStringAsFixed(2)} to balance your expenses. Time to boost your cash flow! 💸💪 \nTalk to LADY NOW!",
                  ).bold().fontSize(14).color(kError700),
                )
              ],
              if(additionalIncomeNeeded < 0)...[
                AppCard(
                  decoration: BoxDecoration(color: kGrey100, borderRadius: BorderRadius.circular(AppThemeUtil.radius(10),),),
                  padding: EdgeInsets.all(AppThemeUtil.radius(10),),
                  child: const Text(
                    "Looks like your spending habit are low, buy what you need! 💸💪\nNeed help? talk to LADY",
                  ).bold().fontSize(14).color(kSuccess600),
                )
              ],
              const VSpace(height: 20),
              const Text("Revenue").extraBold().fontSize(24).color(kPrimaryBlack),
              ListView.builder(
                itemCount: dashboardConsumer.getUserIncome.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  final revenue = dashboardConsumer.getUserIncome[index];
                  return AppListTile(
                    leading: const Icon(Icons.money, color: kSuccess600),
                    title: Text(revenue.nameOfRevenue.toUpperKebabCase).bold().fontSize(16).color(kPrimaryBlack),
                    subtitle: Text("$kCurrency ${revenue.amount.toString().toUpperKebabCase}").medium().fontSize(14).color(kGrey400),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
