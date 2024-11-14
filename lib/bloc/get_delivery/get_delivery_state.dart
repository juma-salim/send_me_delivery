part of 'get_delivery_bloc.dart';

sealed class GetDeliveryState extends Equatable {
  const GetDeliveryState();

  @override
  List<Object> get props => [];
}

final class GetDeliveryInitial extends GetDeliveryState {}

final class GetDeliveryLoading extends GetDeliveryState {}

final class GetDeliverySuccess extends GetDeliveryState {
  final List<Delivery> delivery;

  const GetDeliverySuccess(this.delivery);

  @override
  List<Object> get props => [delivery];
}

final class GetDeliveryFailure extends GetDeliveryState {}
