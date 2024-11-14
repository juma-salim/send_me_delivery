import 'package:delivery_repository/src/models/models.dart';

abstract class DeliveryRepository {
  Future<List<Delivery>> getDeliveries(String id);
  Future<Delivery> addNewDelivery(Delivery delivery);
  Future<void> deleteDelivery(Delivery delivery);
  Future<void> updateDelivery(Delivery delivery);
  Future<List<Delivery>> searchDeliveries(String query);
}
