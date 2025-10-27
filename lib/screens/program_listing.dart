import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_04_app/model/jsonmodel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'program_details.dart';
import 'edit_programs_page.dart';


class ProgramsPage extends StatefulWidget {
  final bool isLearner;

  const ProgramsPage({super.key, required this.isLearner});

  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
  late Future<List<Programlistingmodel>> _programsFuture;



  @override
  void initState() {
    super.initState();
    _programsFuture = fetchPrograms();
  }

  Future<List<Programlistingmodel>> fetchPrograms() async {
    const apiUrl =
        'https://my-json-server.typicode.com/onyx49/Excelerate_MAD-Flutter-_GROUP_04_Oct-Nov_2025/programs';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Programlistingmodel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load programs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.isLearner ? "My Learning Programs" : "Programs",
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black87),
            onPressed: () {
              setState(() {
                _programsFuture = fetchPrograms();
              });
            },
          ),
          if (!widget.isLearner)
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 18),
                label: const Text("Create Program"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: FutureBuilder<List<Programlistingmodel>>(
        future: _programsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading programs: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No programs available.'));
          }

          final programs = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: programs.length,
            itemBuilder: (context, index) {
              final p = programs[index];
              return Padding(
                padding:
                    EdgeInsets.only(bottom: index == programs.length - 1 ? 0 : 16),
                child: ProgramCard(
                  title: p.title ?? '',
                  description: p.description ?? '',
                  students: p.students ?? 0,
                  lessons: p.lessons ?? 0,
                  completion: p.completion ?? 0,
                  startDate: p.startDate ?? DateTime.now(),
                  onViewDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProgramDetailsPage(
                          program: p,
                          isLearner: widget.isLearner,
                        ),
                      ),
                    );
                  },
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditProgramPage(program: p),
                      ),
                    );
                  },
                  isLearner: widget.isLearner,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProgramCard extends StatefulWidget {
  final String title;
  final String description;
  final int students;
  final int lessons;
  final int completion;
  final DateTime startDate;
  final VoidCallback onViewDetails;
  final VoidCallback onEdit;
  final bool isLearner;

  const ProgramCard({
    super.key,
    required this.title,
    required this.description,
    required this.students,
    required this.lessons,
    required this.completion,
    required this.startDate,
    required this.onViewDetails,
    required this.onEdit,
    required this.isLearner,
  });

  @override
  State<ProgramCard> createState() => _ProgramCardState();
}

class _ProgramCardState extends State<ProgramCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<double>(begin: 0, end: widget.completion / 100)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('MMM d, yyyy').format(widget.startDate);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and tag
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.isLearner ? "enrolled" : "active",
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(widget.description,
              style: const TextStyle(color: Colors.black54, fontSize: 14)),
          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(Icons.people_alt_outlined,
                  size: 18, color: Colors.black54),
              const SizedBox(width: 5),
              Text("${widget.students} students",
                  style: const TextStyle(color: Colors.black54, fontSize: 13)),
              const SizedBox(width: 16),
              const Icon(Icons.menu_book_outlined,
                  size: 18, color: Colors.black54),
              const SizedBox(width: 5),
              Text("${widget.lessons} lessons",
                  style: const TextStyle(color: Colors.black54, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          Text("Start Date: $dateFormatted",
              style: const TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(height: 8),

          const Text("Progress Tracker",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 13)),
          const SizedBox(height: 6),

          AnimatedBuilder(
            animation: _animation,
            builder: (context, _) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: _animation.value,
                minHeight: 8,
                backgroundColor: Colors.grey.shade200,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.lightGreenAccent),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text("${widget.completion}%",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.teal)),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onViewDetails,
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          widget.isLearner ? Colors.teal : Colors.grey.shade100,
                      foregroundColor:
                          widget.isLearner ? Colors.white : Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                      widget.isLearner ? "Continue Learning" : "View Details"),
                ),
              ),
              if (!widget.isLearner) ...[
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onEdit,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text("Edit"),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
