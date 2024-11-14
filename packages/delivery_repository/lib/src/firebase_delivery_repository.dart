import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_repository/src/delivery_repo.dart';
import 'package:delivery_repository/src/entities/entities.dart';
import 'package:delivery_repository/src/models/delivery.dart';
import 'package:uuid/uuid.dart';

class FirebaseDeliveryRepository implements DeliveryRepository {
  final deliveryCollection =
      FirebaseFirestore.instance.collection('deliveries');
  @override
  Future<Delivery> addNewDelivery(Delivery delivery) async {
    try {
      delivery.deliveryNumber = const Uuid().v1();

      await deliveryCollection
          .doc(delivery.deliveryNumber)
          .set(delivery.toEntity().toDocument());

      return delivery;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteDelivery(Delivery delivery) {
    try {
      return deliveryCollection.doc(delivery.deliveryNumber).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Delivery>> getDeliveries(String id) {
    try {
      return deliveryCollection
          .where('userId', isEqualTo: id)
          .get()
          .then((snapshot) {
        return snapshot.docs.map((doc) {
          print(doc.data());
          return Delivery.fromEntity(DeliveryEntity.fromDocument(doc.data()));
        }).toList();
      });
    } on FirebaseException catch (e) {
      log(e.toString());

      rethrow;
    }
  }

  Future<List<Delivery>> searchDeliveries(String query) async {
    try {
      final snapshot = await deliveryCollection
          .where('deliveryNumber', isEqualTo: query)
          .get();

      return snapshot.docs
          .map((doc) {
            final data = doc.data();
            if (data != null) {
              return Delivery.fromEntity(DeliveryEntity.fromDocument(data));
            } else {
              log('Error: Document data is null for doc ID: ${doc.id}');
              return null;
            }
          })
          .where((delivery) => delivery != null)
          .cast<Delivery>()
          .toList();
    } on FirebaseException catch (e) {
      log('FirebaseException: $e');
      return [];
    } catch (e) {
      log('Exception: $e');
      return [];
    }
  }

  @override
  Future<void> updateDelivery(Delivery delivery) {
    try {
      return deliveryCollection
          .doc(delivery.deliveryNumber)
          .update(delivery.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
