import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'program_details.dart';
import 'edit_programs_page.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({super.key});

  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final programs = [
      {
        'title': 'Introduction to Web Development',
        'description': 'Learn the fundamentals of HTML, CSS, and JavaScript',
        'students': 24,
        'lessons': 12,
        'completion': 65,
        'startDate': DateTime(2026, 3, 15),
      },
      {
        'title': 'Advanced React Patterns',
        'description':
            'Master React hooks, context, and advanced state management',
        'students': 18,
        'lessons': 10,
        'completion': 42,
        'startDate': DateTime(2026, 5, 8),
      },
      {
        'title': 'Modern Design Principles',
        'description':
            'Explore typography, color theory, and responsive design',
        'students': 15,
        'lessons': 9,
        'completion': 58,
        'startDate': DateTime(2026, 6, 2),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text(
          "Programs",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black87),
            onPressed: () {},
          ),
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
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: programs.length,
        itemBuilder: (context, index) {
          final p = programs[index];
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: 1,
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 400),
              padding: EdgeInsets.only(bottom: index == programs.length - 1 ? 0 : 16),
              child: ProgramCard(
                title: p['title'] as String,
                description: p['description'] as String,
                students: p['students'] as int,
                lessons: p['lessons'] as int,
                completion: p['completion'] as int,
                startDate: p['startDate'] as DateTime,
                onViewDetails: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProgramDetailsPage(program: p),
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
              ),
            ),
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
    final dateFormatted =
        DateFormat('MMM d, yyyy').format(widget.startDate);

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
          // Title & Active tag
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text("active",
                    style: TextStyle(color: Colors.white, fontSize: 11)),
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
          Text("Avg. completion: ${widget.completion}%",
              style: const TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(height: 10),

          const Text("Student Progress",
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
                child: OutlinedButton(
                  onPressed: widget.onViewDetails,
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text("View Details"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onEdit,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text("Edit",
                  selectionColor: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
