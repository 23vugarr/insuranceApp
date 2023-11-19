import 'package:flutter/material.dart';

class CommentField extends StatelessWidget {
  final TextEditingController controller;
  const CommentField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Comment',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey),
          ),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Please write if there are any comments or issues',
              border: InputBorder.none,
            ),
            maxLines: 4, // Adjust as needed
          ),
        ),
      ],
    );
  }
}