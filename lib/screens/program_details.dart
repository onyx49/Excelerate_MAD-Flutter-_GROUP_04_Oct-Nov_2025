import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:group_04_app/screens/edit_programs_page.dart';
import 'package:group_04_app/model/jsonmodel.dart';
import '../constants.dart';

class ProgramDetailsPage extends StatelessWidget {
  final Programlistingmodel program;
  final bool isLearner;


  const ProgramDetailsPage({
    super.key,
    required this.program,
    required this.isLearner,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatted = program.startDate != null
        ? DateFormat('MMM d, yyyy').format(program.startDate!)
        : 'TBA';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ✅ AppBar with dynamic title
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final isCollapsed = constraints.maxHeight < 120;
                return FlexibleSpaceBar(
                  titlePadding: EdgeInsets.symmetric(
                      horizontal: isCollapsed ? 50 : 15, vertical: 12),
                  title: Text(
                    program.title ?? "Program Details",
                    style: TextStyle(
                      color: isCollapsed ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1550751827-4bd374c3f58b',
                        fit: BoxFit.cover,
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black87],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ✅ Body content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: const [
                      Icon(Icons.school, color: apptheme),
                      SizedBox(width: 8),
                      Text(
                        "Offered by Saint Louis University",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // About Section
                  const Text(
                    "About this Program",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    program.description ??
                        "No description available for this program.",
                    style: const TextStyle(height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // Key Highlights Section
                  const Text(
                    "Key Highlights",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.play_circle_fill_outlined),
                        title: Text(
                            "Lessons: ${program.lessons ?? 0} • Students: ${program.students ?? 0}"),
                      ),
                      const ListTile(
                        leading: Icon(Icons.timer_outlined),
                        title: Text("Approx. 6 months to complete"),
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.workspace_premium_outlined),
                        title: Text(
                            "Progress: ${program.completion?.toString() ?? '0'}%"),
                      ),
                      ListTile(
                        leading: const Icon(Icons.calendar_today_outlined),
                        title: Text("Start Date: $dateFormatted"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Instructor
                  const Text(
                    "Instructor",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1603415526960-f7e0328c63b1'),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Dr. Jane Foster",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text("Professor of Data Science, Stanford"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Curriculum
                  const Text(
                    "Program Curriculum",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.book_outlined),
                          title: Text("Module 1: Introduction to Data Science"),
                        ),
                        Divider(height: 0),
                        ListTile(
                          leading: Icon(Icons.bar_chart_outlined),
                          title: Text("Module 2: Data Analysis with Python"),
                        ),
                        Divider(height: 0),
                        ListTile(
                          leading: Icon(Icons.smart_toy_outlined),
                          title: Text("Module 3: Machine Learning Basics"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),

      // ✅ Bottom button based on user type
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: apptheme,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (!isLearner) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProgramPage(program: program),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('You have enrolled in this program! 🎉'),
                  ),
                );
              }
            },
            child: Text(
              isLearner ? "Enroll Now" : "Edit",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

