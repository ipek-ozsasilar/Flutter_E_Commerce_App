import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app/models/add_card_model.dart';
import 'package:flutter_e_commerce_app/models/product_model.dart';
import 'package:flutter_e_commerce_app/product/enums/firebase_collections.dart';

class BaseFirebase<T> {
  final FirebaseCollections firebaseCollections;

  BaseFirebase({required this.firebaseCollections});

  //collectionReference -> FirebaseFirestore.instance.collection(name);
  CollectionReference get referanceCollection =>
      firebaseCollections.collectionReference;

  //snapshot.data() yaptığında sadece Map<String, dynamic> gelir. doc.id ayrıca alınır.
  Future<List<T?>> getData() async {
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

        // Collection'a göre doğru model sınıfını kullan
        switch (firebaseCollections) {
          case FirebaseCollections.products:
            return ProductModel.fromJson(docDatas) as T;
          case FirebaseCollections.cards:
            return AddCardModel.fromJson(docDatas) as T;
          default:
            throw Exception(
              'Desteklenmeyen collection: ${firebaseCollections.name}',
            );
        }
      }).toList();

      print("Toplam ${products.length} ürün yüklendi");
      return products;
    } catch (e) {
      print("Firebase hatası: $e");
      return [];
    }
  }

  Future<void> sendData(
    String? name,
    int? number,
    String? expiry,
    int? cvv,
  ) async {
    try {
      referanceCollection.add(
        AddCardModel(
          name: name,
          number: number,
          expiry: expiry,
          cvv: cvv,
        ).toJon(),
      );
    } catch (e) {
      print("Firebase hatası: $e");
    }
  }
}
