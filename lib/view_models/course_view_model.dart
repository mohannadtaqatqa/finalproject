
// import 'package:flutter/material.dart';
// import 'package:projectfeeds/models/course_model.dart';

// class CourseViewModel extends ChangeNotifier {
//   final CourseModel _courseModel;
//   final String token;
//   List<dynamic> courses = [];
//   Map<int, List<dynamic>> sections = {};
//   Map<int, Map<String, dynamic>> courseSubscriptions = {};
//   bool isLoading = false;

//   CourseViewModel({required this.token}) : _courseModel = CourseModel();

//   Future<void> loadCourses() async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       courses = await _courseModel.getCourses(token);
//       notifyListeners();
//     } catch (e) {
//       print('Error loading courses: $e');
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> loadSections(int courseId) async {
//     try {
//       final courseSections = await _courseModel.getSections(token, courseId);
//       sections[courseId] = courseSections;
//       notifyListeners();
//     } catch (e) {
//       print('Error loading sections: $e');
//     }
//   }

//   Future<void> loadSubscriptions() async {
//     try {
//       courseSubscriptions = await _courseModel.getSubscriptions(token);
//       notifyListeners();
//     } catch (e) {
//       print('Error loading subscriptions: $e');
//     }
//   }

//   Future<void> subscribe(int courseId, int sectionId) async {
//     try {
//       await _courseModel.subscribeSection(token, courseId, sectionId);
//       await loadSubscriptions();
//     } catch (e) {
//       print('Error subscribing: $e');
//     }
//   }

//   Future<void> unsubscribe(int courseId, int sectionId) async {
//     final subscriptionId = courseSubscriptions[courseId]?['subscription_id'];
//     if (subscriptionId != null) {
//       try {
//         await _courseModel.unsubscribeSection(token, courseId, sectionId, subscriptionId);
//         await loadSubscriptions();
//       } catch (e) {
//         print('Error unsubscribing: $e');
//       }
//     }
//   }
// }



import 'package:flutter/material.dart';
import 'package:projectfeeds/models/course_model.dart';

class CourseViewModel extends ChangeNotifier {
  final CourseModel _courseModel;
  final String token;
  List<dynamic> courses = [];
  Map<int, List<dynamic>> sections = {};
  Map<int, Map<String, dynamic>> sectionSubscriptions = {};
  bool isLoading = false;

  CourseViewModel({required this.token}) : _courseModel = CourseModel();

  Future<void> loadCourses() async {
    isLoading = true;
    notifyListeners();
    try {
      courses = await _courseModel.getCourses(token);
      notifyListeners();
    } catch (e) {
      print('Error loading courses: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSections(int courseId) async {
    try {
      final courseSections = await _courseModel.getSections(token, courseId);
      sections[courseId] = courseSections;
      notifyListeners();
    } catch (e) {
      print('Error loading sections: $e');
    }
  }

  Future<void> loadSubscriptions() async {
    try {
      sectionSubscriptions = await _courseModel.getSubscriptions(token);
      notifyListeners();
    } catch (e) {
      print('Error loading subscriptions: $e');
    }
  }

  Future<void> subscribe(int courseId, int sectionId) async {
    try {
      await _courseModel.subscribeSection(token, courseId, sectionId);
      await loadSubscriptions();
    } catch (e) {
      print('Error subscribing: $e');
    }
  }

  Future<void> unsubscribe(int courseId, int sectionId) async {
    final subscriptionId = sectionSubscriptions[sectionId]?['subscription_id'];
    if (subscriptionId != null) {
      try {
        await _courseModel.unsubscribeSection(token, courseId, sectionId, subscriptionId);
        await loadSubscriptions();
      } catch (e) {
        print('Error unsubscribing: $e');
      }
    }
  }
}
