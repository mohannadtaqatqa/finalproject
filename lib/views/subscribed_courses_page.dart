import 'package:flutter/material.dart';
import 'package:projectfeeds/views/course_list_page.dart';
import 'package:provider/provider.dart';
import 'package:projectfeeds/view_models/subscribed_courses_viewmodel.dart';
import 'package:projectfeeds/views/course_detail_page.dart';
import 'package:projectfeeds/models/course_subscription_model.dart';

class SubscribedCoursesPage extends StatelessWidget {
  final String token;

  const SubscribedCoursesPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          SubscribedCoursesViewModel(token: token)..fetchSubscriptions(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Subscribed Courses",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(
          child: Column(
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
          ),
        ),
        body: Consumer<SubscribedCoursesViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }

            if (viewModel.errorMessage != null) {
              return Center(
                child: Text(
                  viewModel.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            if (viewModel.courseSubscriptions.isEmpty) {
              return const Center(
                child: Text(
                  "No subscribed courses available.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              itemCount: viewModel.courseSubscriptions.length,
              itemBuilder: (context, index) {
                final CourseSubscription subscription =
                    viewModel.courseSubscriptions[index];

                return Card(
                  elevation: 6,
                  shadowColor: Colors.blue.withOpacity(0.3),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: const Icon(Icons.book, color: Colors.blue),
                    ),
                    title: Text(
                      subscription.courseName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Section: ${subscription.sectionName}\nLecturer: ${subscription.lecturer}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: Chip(
                      label: Text(subscription.collegeName),
                      backgroundColor: Colors.blue[50],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseDetailPage(
                            courseDetails: subscription,
                            token: token,
                          ),
                        ),
                      );
                    },
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
