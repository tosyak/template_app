import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    required this.child,
    this.color,
  });

  final Widget child;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        minHeight: 52.h,
      ),
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(15.r)),
      child: child,
    );
  }
}
