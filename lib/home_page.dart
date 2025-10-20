import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import '/program_listing.dart';

class DashboardPage extends StatelessWidget {
  final bool isLearner;

  const DashboardPage({super.key, required this.isLearner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.deepPurple),
          onPressed: () {
            context.go('/'); // Return to login screen
          },
        ),
        title: Text(
          isLearner ? "Learner Dashboard" : "Educator Dashboard",
          style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back!",
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  isLearner
                      ? "Access your enrolled courses and track your learning progress."
                      : "Manage your courses, communicate with learners, and track progress.",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),

                // Dashboard cards
                DashboardCard(
                  icon: Icons.mail_outline,
                  title: 'Inbox',
                  subtitle: 'Messages and conversations',
                  badgeCount: 3,
                  color: Colors.blueAccent,
                   onTap: (){},
                //   onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => ProgramsPage()),
                // ),
                ),
                DashboardCard(
                  icon: Icons.menu_book_rounded,
                  title: 'Programs',
                  subtitle:
                      isLearner ? 'Your enrolled courses' : 'Manage your courses',
                  badgeCount: 0,
                  color: Colors.teal,
                   onTap: (){
                    context.push('/program_listing');
                   },
                //   onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => ProgramsPage()),
                // ),
                ),
                DashboardCard(
                  icon: Icons.check_box_outlined,
                  title: 'Tasks',
                  subtitle:
                      isLearner ? 'Your assignments' : 'Assignments and grading',
                  badgeCount: 5,
                  color: Colors.deepOrangeAccent,
                   onTap: (){},
                //   onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => ProgramsPage()),
                // ),
                ),
                DashboardCard(
                  icon: Icons.campaign_outlined,
                  title: 'Announcements',
                  subtitle:
                      isLearner ? 'Latest updates' : 'Post updates for learners',
                  badgeCount: 2,
                  color: Colors.deepPurpleAccent,
                   onTap: (){},
                //   onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => ProgramsPage()),
                // ),
                ),

                const SizedBox(height: 20),

                // Stats Card
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isLearner ? "2" : "24",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Text(
                        isLearner ? "Courses Enrolled" : "Total Students",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
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

// Reusable Dashboard Card
class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int badgeCount;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.badgeCount,
    required this.color,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
      
       child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          radius: 24,
          child: Icon(icon, color: color, size: 26),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: badgeCount > 0
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeCount.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            : null,
      ),
      ),
    );
  }
}