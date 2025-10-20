import 'package:flutter/material.dart';

class EditProgramPage extends StatefulWidget {
  final Map<String, dynamic> program;
  const EditProgramPage({super.key, required this.program});

  @override
  State<EditProgramPage> createState() => _EditProgramPageState();
}

class _EditProgramPageState extends State<EditProgramPage> {
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.program['title']);
    descController = TextEditingController(text: widget.program['description']);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Program")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Program Title"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // handle save logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Program updated successfully")),
                );
                Navigator.pop(context);
              },
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
