

import 'dart:convert';
import 'package:http/http.dart' as http;

class CourseModel {
  final String courseUrl = "http://feeds.ppu.edu/api/v1/courses";
  final String subscriptionsUrl = "http://feeds.ppu.edu/api/v1/subscriptions";

  Future<List<dynamic>> getCourses(String token) async {
    final response = await http.get(
      Uri.parse(courseUrl),
      headers: {"Authorization": token},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['courses'];
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<List<dynamic>> getSections(String token, int courseId) async {
    final response = await http.get(
      Uri.parse("$courseUrl/$courseId/sections"),
      headers: {"Authorization": token},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['sections'];
    } else {
      throw Exception('Failed to load sections');
    }
  }

  Future<Map<int, Map<String, dynamic>>> getSubscriptions(String token) async {
    final response = await http.get(
      Uri.parse(subscriptionsUrl),
      headers: {"Authorization": token},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['subscriptions'];
      final Map<int, Map<String, dynamic>> subscriptions = {};
      for (var sub in data) {
        subscriptions[sub['section_id']] = {
          'course': sub['course'],
          'lecturer': sub['lecturer'],
          'subscription_id': sub['id'],
        };
      }
      return subscriptions;
    } else {
      throw Exception('Failed to load subscriptions');
    }
  }

  Future<void> subscribeSection(String token, int courseId, int sectionId) async {
    final url =
        "http://feeds.ppu.edu/api/v1/courses/$courseId/sections/$sectionId/subscribe";
    final response = await http.post(
      Uri.parse(url),
      headers: {"Authorization": token},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to subscribe');
    }
  }

  Future<void> unsubscribeSection(
      String token, int courseId, int sectionId, int subscriptionId) async {
    final url =
        "http://feeds.ppu.edu/api/v1/courses/$courseId/sections/$sectionId/subscribe/$subscriptionId";
    final response = await http.delete(
      Uri.parse(url),
      headers: {"Authorization": token},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to unsubscribe');
    }
  }
}
