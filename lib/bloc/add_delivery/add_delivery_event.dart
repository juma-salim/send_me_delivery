part of 'add_delivery_bloc.dart';

sealed class AddDeliveryEvent extends Equatable {
  const AddDeliveryEvent();

  @override
  List<Object> get props => [];
}

class CreateDelivery extends AddDeliveryEvent {
  final Delivery delivery;

  const CreateDelivery(this.delivery);

  @override
  List<Object> get props => [delivery];
}
