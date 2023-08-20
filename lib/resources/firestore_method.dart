import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piczo/models/comment_model.dart';
import 'package:piczo/models/post.dart';
import 'package:piczo/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profileImage) async {
    String res = "something went wrong";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("posts", file, true);

      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          postId: postId,
          username: username,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profileImage: profileImage,
          likes: []);

      //Upload post to firestore
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "post uploaded successfully";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      // if already liked the post
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> postComment(String commentText, String postId, String uid,
      String username, String profilePic) async {
    String res = "something went wrong";
    try {
      if (commentText.isNotEmpty) {
        String commentId = const Uuid().v1();
        CommentModel comment = CommentModel(
            comment: commentText,
            commentId: commentId,
            datePublished: DateTime.now(),
            postId: postId,
            uid: uid,
            username: username,
            profilePic: profilePic
            );
       await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set(comment.toJson());
        res = "success";
      } else {
        res = "empty-field";
      }
    } catch (e) {
      print(e.toString());
      res = e.toString();
    }
    return res;
  }
}
