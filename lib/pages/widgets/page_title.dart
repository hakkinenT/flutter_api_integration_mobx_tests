import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
      ),
    );
  }
}
