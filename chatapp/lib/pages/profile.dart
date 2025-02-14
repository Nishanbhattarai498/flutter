import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chatapp/services/shared_pref.dart';
import 'package:chatapp/pages/onboarding.dart';
import 'package:chatapp/services/database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  String name = "";
  String email = "";
  String profilePicUrl = "";

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user!.uid).get();
      setState(() {
        name = userDoc["Name"] ?? "Unknown";
        email = userDoc["Email"] ?? user!.email!;
        profilePicUrl = userDoc["Image"] ?? "https://via.placeholder.com/150";
      });
    }
  }

  Future<void> _updateProfilePic() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    File file = File(image.path);

    UploadTask uploadTask = FirebaseStorage.instance
        .ref('profile_pics/${user!.uid}.jpg')
        .putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    await _firestore
        .collection('users')
        .doc(user!.uid)
        .update({"Image": downloadUrl});
    setState(() {
      profilePicUrl = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _updateProfilePic,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profilePicUrl),
              ),
            ),
            SizedBox(height: 20),
            _buildProfileInfo(Icons.person, "Name", name),
            _buildProfileInfo(Icons.email, "Email", email),
            SizedBox(height: 20),
            _buildActionTile(Icons.logout, "LogOut", Colors.black, _logout),
            _buildActionTile(
                Icons.delete, "Delete Account", Colors.red, _deleteAccount),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(IconData icon, String title, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.purple),
        title: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
        subtitle:
            Text(value, style: TextStyle(fontSize: 16, color: Colors.black)),
      ),
    );
  }

  Widget _buildActionTile(
      IconData icon, String title, Color iconColor, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Future<void> _logout() async {
    await _auth.signOut();
    await SharedPreferenceHelper().clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Onboarding()));
  }

  Future<void> _deleteAccount() async {
    try {
      // Delete user messages
      await DatabaseMethods().deleteUserMessages(user!.uid);

      // Delete user document
      await _firestore.collection('users').doc(user!.uid).delete();
      await user!.delete();
      await SharedPreferenceHelper().clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Onboarding()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error deleting account: $e"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
