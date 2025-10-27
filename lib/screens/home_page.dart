import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_04_app/model/jsonmodel.dart';
import 'package:group_04_app/services/FirebaseHelper.dart';
import 'package:group_04_app/services/helper.dart';
import 'package:quickalert/quickalert.dart';

class DashboardPage extends StatelessWidget {
  final bool isLearner;
  final Userjsonmodel currentUser;

  const DashboardPage({
    super.key,
    required this.isLearner,
    required this.currentUser,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.deepPurple),
          onPressed: () async {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.confirm,
              title: 'Confirm Logout',
              text: 'Are you sure you want to log out?',
              confirmBtnText: 'Continue',
              cancelBtnText: 'Cancel',
              confirmBtnColor: Colors.red,
              onConfirmBtnTap: () async {
                Navigator.of(context, rootNavigator: true).pop();
                showProgress("Logging out...");
                await Future.delayed(const Duration(seconds: 2));
                closeLoader();
                await FireStoreUtils.logout();
                if (context.mounted) context.go('/');
              },
            );
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
                  "Welcome back, ${currentUser.email}!",
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
                  onTap: () {},
                ),
                DashboardCard(
                  icon: Icons.menu_book_rounded,
                  title: 'Programs',
                  subtitle: isLearner
                      ? 'Explore and enroll in our courses'
                      : 'Manage your programs',
                  badgeCount: 0,
                  color: Colors.teal,
                  onTap: () {
                    context.push('/program_listing', extra: isLearner);
                  },
                ),
                DashboardCard(
                  icon: Icons.check_box_outlined,
                  title: 'Tasks',
                  subtitle: isLearner
                      ? 'Your assignments'
                      : 'Assignments and grading',
                  badgeCount: 5,
                  color: Colors.deepOrangeAccent,
                  onTap: () {},
                ),
                DashboardCard(
                  icon: Icons.campaign_outlined,
                  title: 'Announcements',
                  subtitle: isLearner
                      ? 'Latest updates'
                      : 'Post updates for learners',
                  badgeCount: 2,
                  color: Colors.deepPurpleAccent,
                  onTap: () {},
                ),

                const SizedBox(height: 20),

                // Stats Card — tappable
                InkWell(
                  onTap: () {
                    context.push(
                      '/courses_enrolled_page',
                      extra: currentUser,
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colors.deepPurple.withOpacity(0.1),
                  child: Container(
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
                          isLearner ? "0" : "24",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Text(
                          isLearner
                              ? "Courses Enrolled"
                              : "Total Students",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
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

final userModel = Userjsonmodel(
  id: 1, // or fetched from backend
  email: 'test@mail.com',
  role: 'learner',
   // optional
);
// Reusable Dashboard Card Widget
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
    required this.onTap,
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
