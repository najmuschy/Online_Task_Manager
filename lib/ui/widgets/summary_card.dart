import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key, required this.count, required this.status,
  });
  final int count ;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          children: [
            Text(count.toString(), style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 26,
            ),),
            Text(status)

          ],
        ),
      ),
    );
  }
}
