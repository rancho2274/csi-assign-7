import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore= FirebaseFirestore.instance;
class StoreData {
  Future<String> uploadimage(String childname, Uint8List file) async {
    Reference ref = _storage.ref().child(childname);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadurl = await snapshot.ref.getDownloadURL();
    return downloadurl;
  }

  Future saveData({required Uint8List file}) async {
    try{
     String imageUrl=await uploadimage('Profile', file);
     await _firestore.collection('user').add({
       'imagelInk': imageUrl,
     });

    }catch(err){
      print('error');
    }

  }

}