part of 'update_delivery_bloc.dart';

sealed class UpdateDeliveryEvent extends Equatable {
  const UpdateDeliveryEvent();

  @override
  List<Object> get props => [];
}

final class UpdateDelivery extends UpdateDeliveryEvent {
  final Delivery delivery;

  const UpdateDelivery(this.delivery);

  @override
  List<Object> get props => [delivery];
}
