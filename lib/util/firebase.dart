import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase {
  static const String _diaries = 'diaries';

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference get diaries => firestore.collection(_diaries);

  static Future<void> write(String a) async {}

  static Query getDiaryfromDate({
    Timestamp? isEq,
    Timestamp? isNotEq,
    Timestamp? isGtEq,
    Timestamp? isGt,
    Timestamp? isLtEq,
    Timestamp? isLt,
  }) {
    final query = diaries.where(
      'date',
      isEqualTo: isEq,
      isNotEqualTo: isNotEq,
      isGreaterThanOrEqualTo: isGtEq,
      isGreaterThan: isGt,
      isLessThanOrEqualTo: isLtEq,
      isLessThan: isLt,
    );

    return query;
  }
}
