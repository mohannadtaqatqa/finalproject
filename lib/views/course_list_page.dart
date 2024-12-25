// import 'package:flutter/material.dart';
// import 'package:projectfeeds/view_models/course_view_model.dart';
// import 'package:projectfeeds/views/Post_page.dart';
// import 'package:provider/provider.dart';
// import 'package:projectfeeds/views/subscribed_courses_page.dart';

// class CourseList extends StatelessWidget {
//   final String token;

//   const CourseList({super.key, required this.token});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => CourseViewModel(token: token)..loadCourses()..loadSubscriptions(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Courses"),
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                 ),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'PPU Feeds',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 margin: const EdgeInsets.all(0),
//                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
//                 child: ListTile(
//                   title: Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Text(
//                       "All Courses",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CourseList(token: token),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
//                 child: ListTile(
//                   title: Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Text(
//                       "Subscribe to a Course",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SubscribedCoursesPage(token: token),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: Consumer<CourseViewModel>(
//           builder: (context, viewModel, child) {
//             if (viewModel.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (viewModel.courses.isEmpty) {
//               return const Center(child: Text("No courses available"));
//             }

//             return ListView.builder(
//               itemCount: viewModel.courses.length,
//               itemBuilder: (context, index) {
//                 final course = viewModel.courses[index];
//                 final courseId = course['id'];
//                 final courseSections = viewModel.sections[courseId] ?? [];
//                 final subscription = viewModel.courseSubscriptions[courseId];

//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.all(8),
//                   child: ExpansionTile(
//                     title: Text(course['name']),
//                     subtitle: Text("College: ${course['college']}"),
//                     onExpansionChanged: (expanded) {
//                       if (expanded && viewModel.sections[courseId] == null) {
//                         viewModel.loadSections(courseId);
//                       }
//                     },
//                     children: courseSections.isEmpty
//                         ? [
//                             const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text("No sections available."),
//                             ),
//                           ]
//                         : courseSections.map((section) {
//                             final sectionId = section['id'];
//                             final isSubscribed = subscription?['section_id'] == sectionId;

//                             return ListTile(
//                               title: Text("Section: ${section['name']}"),
//                               subtitle: Text("Lecturer: ${section['lecturer']}"),
//                               trailing: IconButton(
//                                 icon: Icon(
//                                   isSubscribed ? Icons.check_circle : Icons.cancel,
//                                   color: isSubscribed ? Colors.green : Colors.red,
//                                 ),
//                                 onPressed: () => isSubscribed
//                                     ? viewModel.unsubscribe(courseId, sectionId)
//                                     : viewModel.subscribe(courseId, sectionId),
//                               ),
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => PostPage(
//                                       courseId: courseId,
//                                       sectionId: sectionId,
//                                       token: token,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           }).toList(),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:projectfeeds/view_models/course_view_model.dart';
import 'package:projectfeeds/views/Post_page.dart';
import 'package:projectfeeds/views/subscribed_courses_page.dart';
import 'package:provider/provider.dart';

class CourseList extends StatelessWidget {
  final String token;

  const CourseList({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CourseViewModel(token: token)
        ..loadCourses()
        ..loadSubscriptions(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Courses"),
        ),
        drawer: Drawer(
          child:  Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PPU Feeds',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.list_alt, color: Colors.blue),
                title: const Text(
                  "All Courses",
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseList(token: token),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_circle, color: Colors.blue),
                title: const Text(
                  "Subscribe to a Course",
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SubscribedCoursesPage(token: token),
                    ),
                  );
                },
              ),
            ],
          ),  ),

        body: Consumer<CourseViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.courses.isEmpty) {
              return const Center(child: Text("No courses available"));
            }

            return ListView.builder(
              itemCount: viewModel.courses.length,
              itemBuilder: (context, index) {
                final course = viewModel.courses[index];
                final courseId = course['id'];
                final courseSections = viewModel.sections[courseId] ?? [];

                return Card(
                  color: Colors.blue[200],
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: ExpansionTile(
                    title: Text(course['name']),
                    subtitle: Text("College: ${course['college']}"),
                    onExpansionChanged: (expanded) {
                      if (expanded && viewModel.sections[courseId] == null) {
                        viewModel.loadSections(courseId);
                      }
                    },
                    children: courseSections.isEmpty
                        ? [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("No sections available."),
                            ),
                          ]
                        : courseSections.map((section) {
                            final sectionId = section['id'];
                            final isSubscribed = viewModel.sectionSubscriptions
                                .containsKey(sectionId);

                            return ListTile(
                              title: Text("Section: ${section['name']}"),
                              subtitle:
                                  Text("Lecturer: ${section['lecturer']}"),
                              trailing: IconButton(
                                icon: Icon(
                                  isSubscribed
                                      ? Icons.remove_circle
                                      : Icons.add_circle,
                                  color:
                                      isSubscribed ? Colors.red : Colors.green,
                                ),
                                onPressed: () {
                                  if (isSubscribed) {
                                    // Unsubscribe if already subscribed
                                    viewModel.unsubscribe(courseId, sectionId);
                                  } else {
                                    // Subscribe if not subscribed
                                    viewModel.subscribe(courseId, sectionId);
                                  }
                                },
                              ),
                               onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostPage(
                                      courseId: courseId,
                                      sectionId: sectionId,
                                      token: token,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
