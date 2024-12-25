import 'package:flutter/material.dart';
import 'package:projectfeeds/models/coment_model.dart';
import 'package:projectfeeds/view_models/comment_service.dart';
// import 'comment_model.dart';
// import 'comment_service.dart';

class CommentViewModel extends ChangeNotifier {
  final String token;
  final int courseId;
  final int sectionId;
  final int postId;

  List<Comment> _comments = [];
  bool _isLoading = false;
  Map<int, int> _commentLikeCount = {};
  Map<int, bool> _commentLikes = {};

  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;
  Map<int, int> get commentLikeCount => _commentLikeCount;
  Map<int, bool> get commentLikes => _commentLikes;

  CommentViewModel({required this.token, required this.courseId, required this.sectionId, required this.postId});

  Future<void> fetchComments() async {
    _setLoading(true);
    try {
      _comments = await CommentService.getComments(token, courseId, sectionId, postId);
      for (var comment in _comments) {
        await _fetchCommentLikesData(comment.id);
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching comments: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addComment(String body) async {
    try {
      await CommentService.addComment(token, courseId, sectionId, postId, body);
      await fetchComments();
    } catch (e) {
      print('Error adding comment: $e');
    }
  }
 

Future<void> editComment(String body, int commentId) async {
  try {
    await CommentService.editComment(token, courseId, sectionId, postId, body, commentId);

    // Update comment locally instead of re-fetching all comments
    final index = _comments.indexWhere((comment) => comment.id == commentId);
    if (index != -1) {
      _comments[index] = Comment(
        id: _comments[index].id,
        body: body,
        author: _comments[index].author,
        datePosted: _comments[index].datePosted,
      );
    }
    notifyListeners();
  } catch (e) {
    print('Error editing comment: $e');
  }
}

Future<void> deleteComment(int commentId) async {
  try {
    await CommentService.deleteComment(token, courseId, sectionId, postId, commentId);

    // Remove comment locally instead of re-fetching all comments
    _comments.removeWhere((comment) => comment.id == commentId);
    notifyListeners();
  } catch (e) {
    print('Error deleting comment: $e');
  }
}

  Future<void> toggleLike(int commentId) async {
    try {
      await CommentService.toggleLike(token, courseId, sectionId, postId, commentId);
      await _fetchCommentLikesData(commentId);
      notifyListeners();
    } catch (e) {
      print('Error toggling like: $e');
    }
  }

  Future<void> _fetchCommentLikesData(int commentId) async {
    final likeCount = await CommentService.getCommentLikesCount(token, courseId, sectionId, postId, commentId);
    final liked = await CommentService.getCommentLikeStatus(token, courseId, sectionId, postId, commentId);

    _commentLikeCount[commentId] = likeCount;
    _commentLikes[commentId] = liked;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

