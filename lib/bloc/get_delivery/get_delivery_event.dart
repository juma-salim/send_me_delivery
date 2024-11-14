part of 'get_delivery_bloc.dart';

sealed class GetDeliveryEvent extends Equatable {
  const GetDeliveryEvent();

  @override
  List<Object> get props => [];
}

final class GetDelivery extends GetDeliveryEvent {
  final String userId;

  const GetDelivery(this.userId);

  @override
  List<Object> get props => [userId];
}

final class SearchDelivery extends GetDeliveryEvent {
  final String query;

  const SearchDelivery(this.query);

  @override
  List<Object> get props => [query];
}
