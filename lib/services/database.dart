import 'package:cloud_firestore/cloud_firestore.dart';



class MyDatabase {
  // Future<List<PostModel>> fetchItems(PostModel? post) async {
  //   final itemsCollectionRef = FirebaseFirestore.instance.collection('posts');
  //
  //   if (post == null) {
  //     final documentSnapshot = await itemsCollectionRef
  //         .orderBy("timestamp", descending: true)
  //         .limit(1000)
  //         .get();
  //
  //     return documentSnapshot.docs
  //         .map<PostModel>(
  //           (data) => PostModel.fromJson(data.data()),
  //     )
  //         .toList();
  //   } else {
  //     final documentSnapshot = await itemsCollectionRef
  //         .orderBy("timestamp", descending: true)
  //         .startAfter([post.timestamp])
  //         .limit(1000)
  //         .get();
  //
  //     return documentSnapshot.docs
  //         .map<PostModel>(
  //           (data) => PostModel.fromJson(data.data()),
  //     )
  //         .toList();
  //   }
  // }

}