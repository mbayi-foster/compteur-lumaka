import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TensionRecord extends FirestoreRecord {
  TensionRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "month" field.
  int? _month;
  int get month => _month ?? 0;
  bool hasMonth() => _month != null;

  // "qte" field.
  double? _qte;
  double get qte => _qte ?? 0.0;
  bool hasQte() => _qte != null;

  void _initializeFields() {
    _month = castToType<int>(snapshotData['month']);
    _qte = castToType<double>(snapshotData['qte']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tension');

  static Stream<TensionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TensionRecord.fromSnapshot(s));

  static Future<TensionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TensionRecord.fromSnapshot(s));

  static TensionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TensionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TensionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TensionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TensionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TensionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTensionRecordData({
  int? month,
  double? qte,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'month': month,
      'qte': qte,
    }.withoutNulls,
  );

  return firestoreData;
}

class TensionRecordDocumentEquality implements Equality<TensionRecord> {
  const TensionRecordDocumentEquality();

  @override
  bool equals(TensionRecord? e1, TensionRecord? e2) {
    return e1?.month == e2?.month && e1?.qte == e2?.qte;
  }

  @override
  int hash(TensionRecord? e) => const ListEquality().hash([e?.month, e?.qte]);

  @override
  bool isValidKey(Object? o) => o is TensionRecord;
}
