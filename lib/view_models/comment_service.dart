import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projectfeeds/models/coment_model.dart';

class CommentService {
  static const String baseUrl = "http://feeds.ppu.edu/api/v1";

  static Future<List<Comment>> getComments(
      String token, int courseId, int sectionId, int postId) async {
    final String url =
        "$baseUrl/courses/$courseId/sections/$sectionId/posts/$postId/comments";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": token,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['comments'];
        return data
            .map((commentJson) => Comment.fromJson(commentJson))
            .toList();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception('Error fetching comments: $e');
    }
  }

  static Future<void> addComment(String token, int courseId, int sectionId,
      int postId, String body) async {
    final String url =
        "$baseUrl/courses/$courseId/sections/$sectionId/posts/$postId/comments";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"body": body}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add comment');
      }
    } catch (e) {
      throw Exception('Error adding comment: $e');
    }
  }

  // static Future<void> editComment(String token, int courseId, int sectionId,
  //     int postId, String body, int commentsId) async {
  //   final String url =
  //       "$baseUrl/courses/$courseId/sections/$sectionId/posts/$postId/comments/$commentsId";
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         "Authorization": token,
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode({"body": body}),
  //     );

  //     if (response.statusCode != 200) {
  //       throw Exception('Failed to add comment');
  //     }
  //   } catch (e) {
  //     throw Exception('Error adding comment: $e');
  //   }
  // }

  static Future<void> editComment(String token, int courseId, int sectionId,
      int postId, String body, int commentsId) async {
    final String url =
        "$baseUrl/courses/$courseId/sections/$sectionId/posts/$postId/comments/$commentsId";
    try {
      final response = await http.put(
        // Changed from post to put
        Uri.parse(url),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"body": body}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to edit comment');
      }
    } catch (e) {
      throw Exception('Error editing comment: $e');
    }
  }

  static Future<void> deleteComment(String token, int courseId, int sectionId,
      int postId, int commentId) async {
    final String url =
        "$baseUrl/courses/$courseId/sections/$sectionId/posts/$postId/comments/$commentId";
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": token,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete comment');
      }
    } catch (e) {
      throw Exception('Error deleting comment: $e');
    }
  }

  static Future<void> toggleLike(String token, int courseId, int sectionId,
      int postId, int commentId) async {
    final String url =
        "$baseUrl/courses/$courseId/sections/$sectionId/posts/$postId/comments/$commentId/like";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": token,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to toggle like');
      }
    } catch (e) {
      throw Exception('Error toggling like: $e');
    }
  }

  static Future<int> getCommentLikesCount(String token, int courseId,
      int sectionId, int postId, int commentId) async {
    final String url =
        "$baseUrl/courses/$courseId/sections/$sectionId/posts/$postId/comments/$commentId/likes";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": token,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['likes_count'];
      } else {
        throw Exception('Failed to fetch like count');
      }
    } catch (e) {
      throw Exception('Error fetching like count: $e');
    }
  }

  static Future<bool> getCommentLikeStatus(String token, int courseId,
      int sectionId, int postId, int commentId) async {
    final String url =
        "$baseUrl/courses/$courseId/sections/$sectionId/posts/$postId/comments/$commentId/like";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": token,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['liked'];
      } else {
        throw Exception('Failed to fetch like status');
      }
    } catch (e) {
      throw Exception('Error fetching like status: $e');
    }
  }
}
