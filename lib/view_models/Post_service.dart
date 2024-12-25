// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class PostService {
//   static const String postUrl = "http://feeds.ppu.edu/api/v1/courses";

//   // Fetch posts
//   static Future<List<Map<String, dynamic>>> getPosts(
//       String token, int courseId, int sectionId) async {
//     try {
//       final response = await http.get(
//         Uri.parse("$postUrl/$courseId/sections/$sectionId/posts"),
//         headers: {"Authorization": token},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return (data['posts'] as List).cast<Map<String, dynamic>>();
//       }
//     } catch (e) {
//       print('Error fetching posts: $e');
//     }
//     return [];
//   }

//   // Add a post
//   static Future<Map<String, dynamic>?> addPost(
//       String token, int courseId, int sectionId, String postContent) async {
//     try {
//       final response = await http.post(
//         Uri.parse("$postUrl/$courseId/sections/$sectionId/posts"),
//         headers: {
//           "Authorization": token,
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({"body": postContent}),
//       );

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       }
//     } catch (e) {
//       print('Error adding post: $e');
//     }
//     return null;
//   }

 
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class PostService {
  static const String postUrl = "http://feeds.ppu.edu/api/v1/courses";

  // Fetch posts
  static Future<List<Map<String, dynamic>>> getPosts(
      String token, int courseId, int sectionId) async {
    try {
      final response = await http.get(
        Uri.parse("$postUrl/$courseId/sections/$sectionId/posts"),
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['posts'] as List).cast<Map<String, dynamic>>();
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
    return [];
  }

  // Add a post
  static Future<Map<String, dynamic>?> addPost(
      String token, int courseId, int sectionId, String postContent) async {
    try {
      final response = await http.post(
        Uri.parse("$postUrl/$courseId/sections/$sectionId/posts"),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"body": postContent}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error adding post: $e');
    }
    return null;
  }

  // Edit a post
  static Future<Map<String, dynamic>?> editPost(
      String token, int courseId, int sectionId, int postId, String postContent) async {
    try {
      final response = await http.put(
        Uri.parse("$postUrl/$courseId/sections/$sectionId/posts/$postId"),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"body": postContent}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error editing post: $e');
    }
    return null;
  }
}
