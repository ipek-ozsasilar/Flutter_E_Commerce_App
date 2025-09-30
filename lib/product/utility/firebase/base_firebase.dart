import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app/models/product_model.dart';
import 'package:flutter_e_commerce_app/product/enums/firebase_collections.dart';

class BaseFirebase {
  final FirebaseCollections firebaseCollections;

  BaseFirebase({required this.firebaseCollections});

  //collectionReference -> FirebaseFirestore.instance.collection(name);
  CollectionReference get referanceCollection =>
      firebaseCollections.collectionReference;

  //snapshot.data() yaptığında sadece Map<String, dynamic> gelir. doc.id ayrıca alınır.
  Future<List<ProductModel?>> getData() async {
    try {
      print("Firebase'dan veri çekiliyor...");
      final allCollection = await referanceCollection.get();
      print("Döküman sayısı: ${allCollection.docs.length}");

      if (allCollection.docs.isEmpty) {
        print("Firestore'da hiç veri yok!");
        return [];
      }

      final products = allCollection.docs.map((doc) {
        final docDatas = doc.data() as Map<String, dynamic>;
        docDatas['id'] = doc.id; // ID'yi JSON'a ekle
        print("Veri: $docDatas");
        return ProductModel.fromJson(docDatas);
      }).toList();

      print("Toplam ${products.length} ürün yüklendi");
      return products;
    } catch (e) {
      print("Firebase hatası: $e");
      return [];
    }
  }
}
