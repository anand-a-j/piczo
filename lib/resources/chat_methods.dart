import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ChatMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      String currentUser, String receiver, String message) async {
    try {
      await addOrUpdateCurrentUser(currentUser, receiver);
      await _firestore.collection('chats').doc(currentUser).set({
        'lastMessage': message,
      });

      String messageId = const Uuid().v1();

      await _firestore
          .collection('chats')
          .doc(currentUser)
          .collection(receiver)
          .doc(messageId)
          .set({
        'message': message,
        'sender': currentUser,
        'receiver': receiver,
        'time': DateTime.now(),
        'messageId': messageId
      });

      await addOrUpdateCurrentUser(currentUser, receiver);
      await _firestore
          .collection('chats')
          .doc(receiver)
          .set({"lastMessage": message});

      await _firestore
          .collection('chats')
          .doc(receiver)
          .collection(currentUser)
          .doc(messageId)
          .set({
        'message': message,
        'sender': currentUser,
        'receiver': receiver,
        'time': DateTime.now(),
        'messageId': messageId
      });
    } catch (e) {
      print("chat method error ${e.toString()}");
    }
  }

  // Stream of names of subcollections in the current user doc in chats collection
  Stream<List<Map<String, dynamic>>> getMessagedUsers(String currentUser) {
    return _firestore
        .collection('users')
        .doc(currentUser)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.data() == null) {
        print("Document snap is null");
      }
      if (documentSnapshot.exists) {
        List<Map<String, dynamic>> messages = List.from(
            (documentSnapshot.data()! as Map<String, dynamic>)['chattedUsers']);
        
        return messages;
      } else {
        return [];
      }
    });
  }

  // Stream of messages in the subcollection of the current user doc in chats collection
  Stream<List<Map<String, dynamic>>> getMessageInChat(
      String currentUser, String receiver) {
    return _firestore
        .collection('chats')
        .doc(currentUser)
        .collection(receiver)
        .orderBy('time')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> messages = [];

      for (var doc in querySnapshot.docs) {
        messages.add(doc.data() as Map<String, dynamic>);
      }
      return messages;
    });
  }

  addOrUpdateCurrentUser(String uid, String recieverId) async {
    // Get a referance to the user's document
    DocumentReference<Map<String, dynamic>> docRef =
        _firestore.collection('users').doc(uid);

    // Get current data of user document
    DocumentSnapshot<Map<String, dynamic>> snapshot = await docRef.get();

    // check if the chattedUsers array field already contains a map with the specified username
    List<dynamic> chattedUsers = snapshot.data()!['chattedUsers'];
    int index = chattedUsers.indexWhere((user) => user['user'] == recieverId);

    // If the chattedUsers array field contains a map with the specified username,update the time value of existing username
    if (index != -1) {
      Map<String, dynamic> userData = {
        'user': recieverId,
        'time': Timestamp.now()
      };
      chattedUsers[index] = userData;
      await docRef.update({'chattedUsers': chattedUsers});
    } else {
      // If the chattedUsers array field does not contains a map with the specified username,
      //create a new map with the specified username and current time and add it to chattedUsers array field

      Map<String, dynamic> userData = {
        'user': recieverId,
        'time': Timestamp.now()
      };
      await docRef.update({
        'chattedUsers': FieldValue.arrayUnion([userData])
      });
    }
  }
}
