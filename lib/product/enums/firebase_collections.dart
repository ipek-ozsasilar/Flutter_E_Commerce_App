import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  version,
  android,
  ios;
  
  //Created Collection Reference for data fetch
  CollectionReference get collectionReference => FirebaseFirestore.instance.collection(name);
}

