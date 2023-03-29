import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreUtil {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Get a configuration value from Firestore
  static Future<String?> getConfig() async {
    String docKey = 'simple_chatgpt';
    final docSnapshot = await firestore.collection('configs').doc(docKey).get();

    if (docSnapshot.exists) {
      return docSnapshot.get('openai_key');
    } else {
      return null;
    }
  }
}
