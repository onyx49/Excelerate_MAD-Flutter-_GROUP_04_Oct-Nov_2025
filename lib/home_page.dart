// import 'package:flutter/material.dart';

// void main() {
//   runApp(const EducatorDashboard());
// }

// class EducatorDashboard extends StatelessWidget {
//   const EducatorDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // title: 'Educator Dashboard',
//       // debugShowCheckedModeBanner: false,
//       // theme: ThemeData(
//       //   primarySwatch: Colors.deepPurple,
//       //   scaffoldBackgroundColor: const Color(0xFFF9F7FB),
//       // ),
//       // home: const DashboardPage(),
//     );
//   }
// }

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
        
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Welcome back!",
//                   style: TextStyle(
//                     color: Colors.deepPurple,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 const Text(
//                   "Manage your courses, communicate with learners, and track progress.",
//                   style: TextStyle(
//                     color: Colors.black54,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Cards
//                 DashboardCard(
//                   icon: Icons.mail_outline,
//                   title: 'Inbox',
//                   subtitle: 'Messages and conversations',
//                   badgeCount: 3,
//                   color: Colors.blueAccent,
//                 ),
//                 DashboardCard(
//                   icon: Icons.menu_book_rounded,
//                   title: 'Programs',
//                   subtitle: 'Manage your courses',
//                   badgeCount: 0,
//                   color: Colors.teal,
//                 ),
//                 DashboardCard(
//                   icon: Icons.check_box_outlined,
//                   title: 'Tasks',
//                   subtitle: 'Assignments and grading',
//                   badgeCount: 5,
//                   color: Colors.deepOrangeAccent,
//                 ),
//                 DashboardCard(
//                   icon: Icons.campaign_outlined,
//                   title: 'Announcements',
//                   subtitle: 'Post updates',
//                   badgeCount: 2,
//                   color: Colors.deepPurpleAccent,
//                 ),

//                 const SizedBox(height: 20),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(18),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.15),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: const Column(
//                     children: [
//                       Text(
//                         "24",
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepPurple,
//                         ),
//                       ),
//                       Text(
//                         "Total Students",
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 14,
//                         ),
//                       ),
                      
//                     ],
                    
//                   ),
                  
//                 ),
                
//               ],
//             ),
//           ),
          
//         ),
        
//       ),
//     );
//   }
// }
 



// class DashboardCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final int badgeCount;
//   final Color color;

//   const DashboardCard({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.badgeCount,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.15),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: color.withOpacity(0.1),
//           radius: 24,
//           child: Icon(icon, color: color, size: 26),
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(subtitle),
//         trailing: badgeCount > 0
//             ? Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.pinkAccent,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   badgeCount.toString(),
//                   style: const TextStyle(color: Colors.white, fontSize: 12),
//                 ),
//               )
//             : null,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

void main() {
  runApp(const EducatorDashboard());
}

class EducatorDashboard extends StatelessWidget {
  const EducatorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Educator Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF9F7FB),
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isLearner = false; // <-- Boolean value controlled by the Switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !isLearner ? Text(
                  "Welcome back!",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ) : SizedBox(),
                const SizedBox(height: 5), 
                !isLearner ? Text(
                  "Manage your courses, communicate with learners, and track progress.",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ):
                SizedBox(),
                const SizedBox(height: 20),

                // Dashboard cards
                DashboardCard(
                  icon: Icons.mail_outline,
                  title: 'Inbox',
                  subtitle: 'Messages and conversations',
                  badgeCount: 3,
                  color: Colors.blueAccent,
                ),
                
                DashboardCard(
                  icon: Icons.menu_book_rounded,
                  title: 'Programs',
                  subtitle: !isLearner ? 'Manage your courses' : 'Your enrolled courses',
                  badgeCount: 0,
                  color: Colors.teal,
                ),
                DashboardCard(
                  icon: Icons.check_box_outlined,
                  title: 'Tasks',
                  subtitle: !isLearner ? 'Assignments and grading' : 'Your assignments',
                  badgeCount: 5,
                  color: Colors.deepOrangeAccent,
                ),
                DashboardCard(
                  icon: Icons.campaign_outlined,
                  title: 'Announcements',
                  subtitle: !isLearner ? 'Post updates' : 'Latest updates',
                  badgeCount: 2,
                  color: Colors.deepPurpleAccent,
                ),

                const SizedBox(height: 20),

                // Total Students Card
                Container(
                  alignment:  Alignment.centerLeft,
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
                      !isLearner ?
                      Text(
                        "24",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                        
                      ) :

                      Text(
                        "2",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                         
                      ),
                      
                      Text(
                        !isLearner ? "Total Students" : "Courses Enrolled",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 🔘 Switch Button Section
                Container(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "HOME PAGE FOR : ${isLearner ? "LEARNER" : "EDUCATOR"}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Switch(
                        value: isLearner,
                        activeColor: Colors.deepPurple,
                        onChanged: (value) {
                          setState(() {
                            isLearner = value;
                          });
                        },
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

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.badgeCount,
    required this.color,
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
    );
  }
}
