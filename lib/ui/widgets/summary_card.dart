import 'package:flutter/material.dart';

class SummaryCard extends StatefulWidget {
  const SummaryCard({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Text(
              '${widget.count}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(widget.title),
          ],
        ),
      ),
    );
  }
}
