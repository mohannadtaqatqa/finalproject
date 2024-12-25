import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectfeeds/models/course_subscription_model.dart';

class SubscribedCoursesViewModel extends ChangeNotifier {
  final String token;
  List<CourseSubscription> courseSubscriptions = [];
  bool isLoading = true;
  String? errorMessage;

  SubscribedCoursesViewModel({required this.token});

  Future<void> fetchSubscriptions() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    const String subscriptionsUrl = "http://feeds.ppu.edu/api/v1/subscriptions";
 print("--------------------------------------------------");

 print("git data");
 print("--------------------------------------------------");

    try {
      final response = await http.get(
        Uri.parse(subscriptionsUrl),
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic> && data['subscriptions'] != null) {
          courseSubscriptions = List<CourseSubscription>.from(
            data['subscriptions'].map((sub) => CourseSubscription.fromJson(sub)),
          );
        } else {
          courseSubscriptions = [];
          errorMessage = "No subscriptions found!";
        }
      } else {
        errorMessage = "Failed to fetch subscriptions. Please try again.";
      }
    } catch (e) {
      errorMessage = 'Error fetching subscriptions: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
