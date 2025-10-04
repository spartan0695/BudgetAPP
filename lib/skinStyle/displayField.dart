import 'package:flutter/material.dart';
class DisplayField extends StatelessWidget {
  final String label;
  final String value;

  const DisplayField({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 238, 238, 238),
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.infinity,
          child: Text(value),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}