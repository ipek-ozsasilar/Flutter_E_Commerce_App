import 'package:cloud_firestore/cloud_firestore.dart';

//Firebase Collections enum for fetch data from firebase
enum FirebaseCollections {
  version,
  android,
  ios,
  products;

  //Created Collection Reference for data fetch
  CollectionReference get collectionReference => FirebaseFirestore.instance.collection(name);
}
