part of 'update_delivery_bloc.dart';

sealed class UpdateDeliveryState extends Equatable {
  const UpdateDeliveryState();

  @override
  List<Object> get props => [];
}

final class UpdateDeliveryInitial extends UpdateDeliveryState {}

final class UpdateDeliveryLoading extends UpdateDeliveryState {}

final class UpdateDeliverySuccess extends UpdateDeliveryState {
  final Delivery delivery;

  const UpdateDeliverySuccess(this.delivery);

  @override
  List<Object> get props => [delivery];
}

final class UpdateDeliveryFailure extends UpdateDeliveryState {}
