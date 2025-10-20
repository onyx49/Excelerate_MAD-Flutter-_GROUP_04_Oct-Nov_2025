import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProgramDetailsPage extends StatelessWidget {
  final Map<String, dynamic> program;

  const ProgramDetailsPage({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('MMM d, yyyy').format(program['startDate']);
    return Scaffold(
      appBar: AppBar(
        title: Text(program['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              program['description'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text("📅 Start Date: $date"),
            Text("👥 Students: ${program['students']}"),
            Text("📘 Lessons: ${program['lessons']}"),
            const SizedBox(height: 20),
            Text("Completion: ${program['completion']}%"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
