part of 'add_delivery_bloc.dart';

sealed class AddDeliveryState extends Equatable {
  const AddDeliveryState();

  @override
  List<Object> get props => [];
}

final class AddDeliveryInitial extends AddDeliveryState {}

final class AddDeliveryLoading extends AddDeliveryState {}

final class AddDeliverySuccess extends AddDeliveryState {
  final Delivery delivery;

  const AddDeliverySuccess(this.delivery);

  @override
  List<Object> get props => [delivery];
}

final class AddDeliveryFailure extends AddDeliveryState {}
