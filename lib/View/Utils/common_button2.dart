import 'package:flutter/material.dart';
import 'package:job_finder/View/Utils/Styles/app_colors.dart';

class CommonButton2 extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const CommonButton2({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(child: child),
        ),
      ),
    );
  }
}
