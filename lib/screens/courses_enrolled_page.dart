import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:group_04_app/model/jsonmodel.dart';
import '../constants.dart';
import 'program_details.dart';
import 'feedback_screen.dart'; // 👈 import the feedback page

class CoursesEnrolledPage extends StatefulWidget {
  final Userjsonmodel user;

  const CoursesEnrolledPage({super.key, required this.user});

  @override
  State<CoursesEnrolledPage> createState() => _CoursesEnrolledPageState();
}

class _CoursesEnrolledPageState extends State<CoursesEnrolledPage> {
  List<Programlistingmodel> _allPrograms = [];
  List<Programlistingmodel> _enrolledPrograms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPrograms();
  }

  Future<void> fetchPrograms() async {
    const url =
        "https://my-json-server.typicode.com/onyx49/Excelerate_MAD-Flutter-_GROUP_04_Oct-Nov_2025/programs";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _allPrograms =
            data.map((json) => Programlistingmodel.fromJson(json)).toList();

        if (widget.user.role == "learner" &&
            widget.user.toJson().containsKey("enrolledProgramIds")) {
          final enrolledIds =
              (widget.user.toJson()["enrolledProgramIds"] as List<dynamic>)
                  .map((e) => int.tryParse(e.toString()))
                  .where((e) => e != null)
                  .toList();

          _enrolledPrograms = _allPrograms
              .where((p) => enrolledIds.contains(p.id))
              .toList();
        }

        setState(() => _isLoading = false);
      } else {
        throw Exception("Failed to load programs");
      }
    } catch (e) {
      debugPrint("Error fetching programs: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Courses",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: apptheme))
          : _enrolledPrograms.isEmpty
              ? const Center(
                  child: Text(
                    "You haven’t enrolled in any courses yet.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _enrolledPrograms.length,
                  itemBuilder: (context, index) {
                    final program = _enrolledPrograms[index];
                    final startDate = program.startDate != null
                        ? DateFormat('MMM d, yyyy').format(program.startDate!)
                        : "No date";

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProgramDetailsPage(
                              program: program,
                              isLearner: true,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(program.title ?? "Untitled Program",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              const SizedBox(height: 6),
                              Text(
                                program.description ??
                                    "No description available.",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.black54),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          size: 16, color: apptheme),
                                      const SizedBox(width: 4),
                                      Text(
                                        startDate,
                                        style:
                                            const TextStyle(color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.school,
                                          size: 16, color: apptheme),
                                      const SizedBox(width: 4),
                                      Text(
                                          "${program.students ?? 0} students",
                                          style: const TextStyle(
                                              color: Colors.black87)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              LinearProgressIndicator(
                                value: (program.completion ?? 0) / 100,
                                color: Colors.teal,
                                backgroundColor: Colors.grey.shade300,
                                minHeight: 6,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Progress: ${program.completion ?? 0}%",
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.teal,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

      // 👇 Add floating Feedback button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FeedbackScreen(
                isLearner: widget.user.role == "learner",
                currentUserId: widget.user.id.toString(),
              ),
            ),
          );
        },
        backgroundColor: apptheme,
        icon: const Icon(Icons.feedback_outlined, color: Colors.white),
        label: const Text(
          "Give Feedback",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
