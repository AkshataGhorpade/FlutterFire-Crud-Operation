import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('category');

class Database {
  static String userUid;

  static Future<void> addItem({
     String title,
     String productname,
     String productprice,
     String subcategory,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('subcategory').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "productname" : productname,
      "productprice": productprice,
      "subcategory" : subcategory,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
     String title,
     String docId,
    String productname,
    String productprice,
    String subcategory,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('subcategory').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "productname": productname,
      "productprice": productprice,
      "subcategory": subcategory,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userUid).collection('subcategory');

    return notesItemCollection.snapshots();
  }

  static Future<void> deleteItem({
     String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('subcategory').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
