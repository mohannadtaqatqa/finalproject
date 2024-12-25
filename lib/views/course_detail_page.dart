// import 'package:flutter/material.dart';
// // import 'package:projectfeeds/models/course_detail_model.dart';
// import 'package:projectfeeds/view_models/course_detail_viewmodel.dart';
// // import 'package:projectfeeds/viewmodels/course_detail_viewmodel.dart';
// import 'package:projectfeeds/Course.dart';
// import 'package:projectfeeds/SubscribedCourses.dart';

// class CourseDetailPage extends StatelessWidget {
//   final CourseDetailViewModel viewModel;
//   final String token;

//   const CourseDetailPage({super.key, required this.viewModel, required this.token});

//   @override
//   Widget build(BuildContext context) {
//     final courseDetail = viewModel.courseDetail;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(courseDetail.courseName),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'PPU Feeds',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               margin: const EdgeInsets.all(0),
//               padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
//               child: ListTile(
//                 title: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Text(
//                     "All Courses",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CourseList(token: token),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
//               child: ListTile(
//                 title: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Text(
//                     "Subscribe to a Course",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             SubscribedCoursesPage(token: token),
//                       ));
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Course Name: ${courseDetail.courseName}"),
//             Text("Section: ${courseDetail.sectionName}"),
//             Text("Lecturer: ${courseDetail.lecturer}"),
//             Text("College: ${courseDetail.collegeName}"),
//             Text("Subscription Date: ${courseDetail.subscriptionDate}"),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:projectfeeds/models/course_subscription_model.dart';
import 'package:projectfeeds/views/course_list_page.dart';
import 'package:projectfeeds/views/subscribed_courses_page.dart';

class CourseDetailPage extends StatelessWidget {
  final CourseSubscription courseDetails; // Accept the model directly
  final String token;

  const CourseDetailPage({
    super.key,
    required this.courseDetails,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseDetails.courseName), // Use model data
      ),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PPU Feeds',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                margin: const EdgeInsets.all(0),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: ListTile(
                  title: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "All Courses",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseList(token: token)
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: ListTile(
                  title: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Subscribe to a Course",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SubscribedCoursesPage(token: token),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Course Name: ${courseDetails.courseName}"),
            Text("Section: ${courseDetails.sectionName}"),
            Text("Lecturer: ${courseDetails.lecturer}"),
            Text("College: ${courseDetails.collegeName}"),
            Text("Subscription Date: ${courseDetails.subscriptionDate}"),
          ],
        ),
      ),
    );
  }
}
