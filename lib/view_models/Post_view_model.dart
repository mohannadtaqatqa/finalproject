// import 'package:flutter/material.dart';
// import 'package:projectfeeds/models/Post_service.dart';
// import 'package:projectfeeds/models/post_model.dart';
// // import '../model/post_model.dart';
// // import '../model/post_service.dart';

// class PostViewModel extends ChangeNotifier {
//   final String token;
//   final int courseId;
//   final int sectionId;

//   bool isLoading = false;
//   List<Post> posts = [];

//   PostViewModel({
//     required this.token,
//     required this.courseId,
//     required this.sectionId,
//   });

//   // Fetch posts
//   Future<void> fetchPosts() async {
//     isLoading = true;
//     notifyListeners();

//     final postList = await PostService.getPosts(token, courseId, sectionId);
//     posts = postList.map((json) => Post.fromJson(json)).toList();

//     isLoading = false;
//     notifyListeners();
//   }

//   // Add a new post
//   Future<void> addNewPost(String postContent) async {
//     if (postContent.trim().isEmpty) return;

//     isLoading = true;
//     notifyListeners();

//     final response = await PostService.addPost(token, courseId, sectionId, postContent);
//     if (response != null) {
//       final newPost = Post(
//         id: response['post_id'],
//         author: 'You',
//         body: postContent,
//         datePosted: DateTime.now().toString(),
//       );
//       posts.insert(0, newPost);
//     }

//     isLoading = false;
//     notifyListeners();
//   }
// }


import 'package:flutter/material.dart';
import 'package:projectfeeds/view_models/Post_service.dart';
import 'package:projectfeeds/models/post_model.dart';

class PostViewModel extends ChangeNotifier {
  final String token;
  final int courseId;
  final int sectionId;

  bool isLoading = false;
  List<Post> posts = [];

  PostViewModel({
    required this.token,
    required this.courseId,
    required this.sectionId,
  });

  // Fetch posts
  Future<void> fetchPosts() async {
    isLoading = true;
    notifyListeners();

    final postList = await PostService.getPosts(token, courseId, sectionId);
    posts = postList.map((json) => Post.fromJson(json)).toList();

    isLoading = false;
    notifyListeners();
  }

  // Add a new post
  Future<void> addNewPost(String postContent) async {
    if (postContent.trim().isEmpty) return;

    isLoading = true;
    notifyListeners();

    final response = await PostService.addPost(token, courseId, sectionId, postContent);
    if (response != null) {
      final newPost = Post(
        id: response['post_id'],
        author: 'You',
        body: postContent,
        datePosted: DateTime.now().toString(),
      );
      posts.insert(0, newPost);
    }

    isLoading = false;
    notifyListeners();
  }

  // Edit an existing post
  Future<void> editPost(int postId, String postContent) async {
    if (postContent.trim().isEmpty) return;

    isLoading = true;
    notifyListeners();

    final response = await PostService.editPost(token, courseId, sectionId, postId, postContent);
    if (response != null) {
      final updatedPost = Post(
        id: postId,
        author: 'You',
        body: postContent,
        datePosted: DateTime.now().toString(),
      );
      final index = posts.indexWhere((post) => post.id == postId);
      if (index != -1) {
        posts[index] = updatedPost;
      }
    }

    isLoading = false;
    notifyListeners();
  }
}
