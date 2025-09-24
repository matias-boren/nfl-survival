import 'package:flutter/material.dart';

class BannerAdSlot extends StatelessWidget {
  final bool show;
  const BannerAdSlot({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();
    return Container(
      height: 56,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Text('Ad banner (dev placeholder)'),
    );
  }
}

