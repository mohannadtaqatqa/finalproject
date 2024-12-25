
import 'package:flutter/material.dart';
import 'package:projectfeeds/view_models/comment_view_model.dart';

class CommentsPage extends StatefulWidget {
  final String token;
  final int courseId;
  final int sectionId;
  final int postId;

  const CommentsPage({
    super.key,
    required this.token,
    required this.courseId,
    required this.sectionId,
    required this.postId,
  });

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late CommentViewModel _viewModel;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = CommentViewModel(
      token: widget.token,
      courseId: widget.courseId,
      sectionId: widget.sectionId,
      postId: widget.postId,
    );
    _viewModel.fetchComments(); // Initial fetch of comments
  }

  void _refreshComments() {
    setState(() {
      _viewModel.fetchComments(); // Refresh the comments after adding, deleting, or editing
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
        centerTitle: true,
      ),
      
      body: Stack(
        children: [
          // List of comments
          FutureBuilder(
            future: _viewModel.fetchComments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (_viewModel.comments.isEmpty) {
                return const Center(child: Text("No comments available"));
              }

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80.0), // Adjusted padding
                itemCount: _viewModel.comments.length,
                itemBuilder: (context, index) {
                  final comment = _viewModel.comments[index];
                  final commentId = comment.id;
                  final isLiked = _viewModel.commentLikes[commentId] ?? false;
                  final likeCount = _viewModel.commentLikeCount[commentId] ?? 0;

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                comment.author,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            comment.body,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Posted on: ${comment.datePosted}",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                          const Divider(height: 20),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _viewModel.toggleLike(commentId);
                                  });
                                },
                              ),
                              Text(
                                "$likeCount Likes",
                                style: const TextStyle(fontSize: 14),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () async {
                                  final newBody = await showDialog<String?>(
                                    context: context,
                                    builder: (context) {
                                      final controller = TextEditingController(
                                          text: comment.body);
                                      return AlertDialog(
                                        title: const Text("Edit Comment"),
                                        content: TextField(
                                          controller: controller,
                                          decoration: const InputDecoration(
                                              hintText: "Enter new comment"),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(controller.text),
                                            child: const Text("Update"),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (newBody != null && newBody.isNotEmpty) {
                                    try {
                                      await _viewModel.editComment(
                                          newBody, commentId);
                                      _refreshComments(); // Refresh comments after edit
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Comment updated successfully")),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Failed to update comment: $e")),
                                      );
                                    }
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  final shouldDelete = await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Delete Comment"),
                                        content: const Text(
                                            "Are you sure you want to delete this comment?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(false),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text("Delete",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (shouldDelete ?? false) {
                                    try {
                                      await _viewModel.deleteComment(commentId);
                                      _refreshComments(); // Refresh comments after delete
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Comment deleted successfully")),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Failed to delete comment: $e")),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          // Static bottom section for adding a comment
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            decoration: const InputDecoration(
                              hintText: "Write a comment...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.blue),
                          onPressed: () async {
                            final commentText = _commentController.text.trim();

                            if (commentText.isNotEmpty) {
                              try {
                                await _viewModel.addComment(commentText);
                                _refreshComments(); // Refresh comments after adding
                                _commentController.clear(); // Clear the input field
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Comment added successfully"),
                                ));
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Failed to add comment: $e"),
                                ));
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}
/*
// import 'package:flutter/material.dart';
// import 'package:projectfeeds/view_models/comment_view_model.dart';

// class CommentsPage extends StatefulWidget {
//   final String token;
//   final int courseId;
//   final int sectionId;
//   final int postId;

//   const CommentsPage({
//     super.key,
//     required this.token,
//     required this.courseId,
//     required this.sectionId,
//     required this.postId,
//   });

//   @override
//   _CommentsPageState createState() => _CommentsPageState();
// }

// class _CommentsPageState extends State<CommentsPage> {
//   late CommentViewModel _viewModel;
//   final TextEditingController _commentController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _viewModel = CommentViewModel(
//       token: widget.token,
//       courseId: widget.courseId,
//       sectionId: widget.sectionId,
//       postId: widget.postId,
//     );
//     _viewModel.fetchComments(); // Initial fetch of comments
//   }

//   void _refreshComments() {
//     setState(() {
//       _viewModel.fetchComments(); // Refresh the comments after adding, deleting or editing
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Comments"),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           // List of comments
//           FutureBuilder(
//             future: _viewModel.fetchComments(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               }
//               if (_viewModel.comments.isEmpty) {
//                 return const Center(child: Text("No comments available"));
//               }

//               return ListView.builder(
//                 padding: const EdgeInsets.all(8.0),
//                 itemCount: _viewModel.comments.length,
//                 itemBuilder: (context, index) {
//                   final comment = _viewModel.comments[index];
//                   final commentId = comment.id;
//                   final isLiked = _viewModel.commentLikes[commentId] ?? false;
//                   final likeCount = _viewModel.commentLikeCount[commentId] ?? 0;

//                   return Card(
//                     elevation: 4,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 comment.author,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             comment.body,
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "Posted on: ${comment.datePosted}",
//                             style: const TextStyle(
//                                 color: Colors.grey, fontSize: 12),
//                           ),
//                           const Divider(height: 20),
//                           Row(
//                             children: [
//                               IconButton(
//                                 icon: Icon(
//                                   isLiked
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   color: isLiked ? Colors.red : Colors.grey,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     _viewModel.toggleLike(commentId);
//                                   });
//                                 },
//                               ),
//                               Text(
//                                 "$likeCount Likes",
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.edit,
//                                     color: Colors.blue),
//                                 onPressed: () async {
//                                   final newBody = await showDialog<String?>( 
//                                     context: context,
//                                     builder: (context) {
//                                       final controller =
//                                           TextEditingController(text: comment.body);
//                                       return AlertDialog(
//                                         title: const Text("Edit Comment"),
//                                         content: TextField(
//                                           controller: controller,
//                                           decoration: const InputDecoration(
//                                               hintText: "Enter new comment"),
//                                         ),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () =>
//                                                 Navigator.of(context).pop(),
//                                             child: const Text("Cancel"),
//                                           ),
//                                           TextButton(
//                                             onPressed: () =>
//                                                 Navigator.of(context)
//                                                     .pop(controller.text),
//                                             child: const Text("Update"),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );

//                                   if (newBody != null && newBody.isNotEmpty) {
//                                     try {
//                                       await _viewModel.editComment(newBody, commentId);
//                                       _refreshComments(); // Refresh comments after edit
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                             content: Text(
//                                                 "Comment updated successfully")),
//                                       );
//                                     } catch (e) {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         SnackBar(
//                                             content: Text(
//                                                 "Failed to update comment: $e")),
//                                       );
//                                     }
//                                   }
//                                 },
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.delete,
//                                     color: Colors.red),
//                                 onPressed: () async {
//                                   final shouldDelete = await showDialog<bool>(
//                                     context: context,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                         title: const Text("Delete Comment"),
//                                         content: const Text(
//                                             "Are you sure you want to delete this comment?"),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () =>
//                                                 Navigator.of(context)
//                                                     .pop(false),
//                                             child: const Text("Cancel"),
//                                           ),
//                                           TextButton(
//                                             onPressed: () =>
//                                                 Navigator.of(context)
//                                                     .pop(true),
//                                             child: const Text("Delete",
//                                                 style: TextStyle(
//                                                     color: Colors.red)),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );

//                                   if (shouldDelete ?? false) {
//                                     try {
//                                       await _viewModel.deleteComment(commentId);
//                                       _refreshComments(); // Refresh comments after delete
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                             content: Text(
//                                                 "Comment deleted successfully")),
//                                       );
//                                     } catch (e) {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         SnackBar(
//                                             content: Text(
//                                                 "Failed to delete comment: $e")),
//                                       );
//                                     }
//                                   }
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           // Static bottom section for adding a comment
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 elevation: 8,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _commentController,
//                           decoration: const InputDecoration(
//                             hintText: "Write a comment...",
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.send, color: Colors.blue),
//                         onPressed: () async {
//                           final commentText = _commentController.text.trim();

//                           if (commentText.isNotEmpty) {
//                             try {
//                               await _viewModel.addComment(commentText);
//                               _refreshComments(); // Refresh comments after adding
//                               _commentController.clear(); // Clear the input field
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(const SnackBar(
//                                 content: Text("Comment added successfully"),
//                               ));
//                             } catch (e) {
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(SnackBar(
//                                 content: Text("Failed to add comment: $e"),
//                               ));
//                             }
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
 */