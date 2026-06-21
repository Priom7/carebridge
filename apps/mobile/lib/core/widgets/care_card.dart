import 'package:flutter/material.dart';

import '../theme/carebridge_tokens.dart';

class CareCard extends StatelessWidget {
  const CareCard({required this.child, this.padding, super.key});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(CareSpacing.md),
        child: child,
      ),
    );
  }
}
