import 'package:expense_tracker/core/constants/colors.dart';
import 'package:flutter/material.dart';



class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: kPrimaryBlack),
    );
  }
}