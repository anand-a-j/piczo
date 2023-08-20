import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String comment;
  final String commentId;
  final String postId;
  final String uid;
  final String profilePic;
  final String username;
  final datePublished;

  CommentModel(
      {required this.comment,
      required this.commentId,
      required this.datePublished,
      required this.postId,
      required this.uid,
      required this.username,
      required this.profilePic});

  Map<String, dynamic> toJson() => {
        'comment': comment,
        'commentId': commentId,
        'datePublished': datePublished,
        'postId': postId,
        'uid': uid,
        'username': username,
        'profilePic': profilePic
      };

  static CommentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CommentModel(
        comment: snapshot['comment'],
        commentId: snapshot['commentId'],
        datePublished: snapshot['datePublished'],
        postId: snapshot['postId'],
        uid: snapshot['uid'],
        username: snapshot['username'],
        profilePic: snapshot['profilePic']);
  }
}
