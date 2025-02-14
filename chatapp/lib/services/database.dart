import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<QuerySnapshot> search(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('SearchKey', isEqualTo: username.substring(0, 1).toUpperCase())
        .get();
  }

  Future addUser(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  Future<void> createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();
    if (!snapshot.exists) {
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Stream<QuerySnapshot> getChatRoomMessages(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getUserChatRooms(String username) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .where('users', arrayContains: username)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
  }

  Future<void> deleteUserMessages(String userId) async {
    QuerySnapshot chatRoomsSnapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where('users', arrayContains: userId)
        .get();
    for (var doc in chatRoomsSnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
