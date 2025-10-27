import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:group_04_app/model/jsonmodel.dart';
import '../constants.dart';

class EditProgramPage extends StatefulWidget {
  final Programlistingmodel program;

  const EditProgramPage({super.key, required this.program});

  @override
  State<EditProgramPage> createState() => _EditProgramPageState();
}

class _EditProgramPageState extends State<EditProgramPage> {
  late TextEditingController titleController;
  late TextEditingController descController;
  late TextEditingController lessonsController;
  late TextEditingController studentsController;
  late TextEditingController completionController;
  DateTime? selectedDate;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.program.title ?? "");
    descController = TextEditingController(text: widget.program.description ?? "");
    lessonsController =
        TextEditingController(text: widget.program.lessons?.toString() ?? "");
    studentsController =
        TextEditingController(text: widget.program.students?.toString() ?? "");
    completionController =
        TextEditingController(text: widget.program.completion?.toString() ?? "");
    selectedDate = widget.program.startDate;
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    lessonsController.dispose();
    studentsController.dispose();
    completionController.dispose();
    super.dispose();
  }

  Future<void> updateProgram() async {
    setState(() => _isSaving = true);

    final updatedProgram = Programlistingmodel(
      id: widget.program.id,
      title: titleController.text.trim(),
      description: descController.text.trim(),
      lessons: int.tryParse(lessonsController.text),
      students: int.tryParse(studentsController.text),
      completion: int.tryParse(completionController.text),
      startDate: selectedDate,
    );

    final url =
        "https://my-json-server.typicode.com/onyx49/Excelerate_MAD-Flutter-_GROUP_04_Oct-Nov_2025/programs/${widget.program.id}";

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedProgram.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Program updated successfully!")),
        );
        Navigator.pop(context, updatedProgram);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("⚠️ Failed to update. Code: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e")),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          "Edit Program",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: _isSaving
          ? const Center(child: CircularProgressIndicator(color: apptheme))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Program Title",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                            hintText: "Enter program title"),
                      ),
                      const SizedBox(height: 20),

                      const Text("Description",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextField(
                        controller: descController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            hintText: "Enter program description"),
                      ),
                      const SizedBox(height: 20),

                      const Text("Number of Lessons",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextField(
                        controller: lessonsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: "Enter total lessons"),
                      ),
                      const SizedBox(height: 20),

                      const Text("Number of Students",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextField(
                        controller: studentsController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(hintText: "Enter students count"),
                      ),
                      const SizedBox(height: 20),

                      const Text("Completion (%)",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextField(
                        controller: completionController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: "Enter completion percentage"),
                      ),
                      const SizedBox(height: 20),

                      const Text("Start Date",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: pickDate,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Colors.grey.shade400, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDate != null
                                    ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
                                    : "Select start date",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.calendar_today,
                                  color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.save),
                          label: const Text("Save Changes",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: apptheme,
                            padding:
                                const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: updateProgram,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
