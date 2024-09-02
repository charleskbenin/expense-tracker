import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/core/constants/common.dart';
import 'package:expense_tracker/core/extensions/widgets/text_extension.dart';
import 'package:expense_tracker/core/utils/app_theme_util.dart';
import 'package:expense_tracker/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:expense_tracker/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:expense_tracker/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:expense_tracker/src/shared_widgets/common/app_list_tile.dart';
import 'package:expense_tracker/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/view_models/user_view_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      hasLeading: false,
      title: "Settings",
      bottomNavigationBar: AppBottomNavWrapper(
        child: AppPrimaryButton(
          onPressed: () async {
            await context.read<UserViewModel>().signOut(context);
          },
          text: "Log Out",
          color: kError700,
          borderColor: kError700,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: kWidthPadding),
        children: [
          CircleAvatar(
            radius: AppThemeUtil.radius(50),
            backgroundColor: kBlue800,
            child: const Text("CB").extraBold().fontSize(50).color(kPrimaryWhite),
          ),
          const VSpace(height: 20),
          AppListTile(
            title: const Text("Personal Details").bold().fontSize(20).color(kPrimaryBlack),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: (){},
          ),
          AppListTile(
            title: const Text("Support").bold().fontSize(20).color(kPrimaryBlack),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: (){},
          ),
          AppListTile(
            title: const Text("App Preference").bold().fontSize(20).color(kPrimaryBlack),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: (){},
          ),

        ],
      ),
    );
  }
}
