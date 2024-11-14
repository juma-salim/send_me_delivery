import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delivery_repository/delivery_repository.dart';
import 'package:equatable/equatable.dart';

part 'add_delivery_event.dart';
part 'add_delivery_state.dart';

class AddDeliveryBloc extends Bloc<AddDeliveryEvent, AddDeliveryState> {
  final DeliveryRepository _deliveryRepository;
  AddDeliveryBloc({required DeliveryRepository deliveryRepository})
      : _deliveryRepository = deliveryRepository,
        super(AddDeliveryInitial()) {
    on<CreateDelivery>((event, emit) {
      try {
        emit(AddDeliveryLoading());
        _deliveryRepository.addNewDelivery(event.delivery);
        emit(AddDeliverySuccess(event.delivery));
      } catch (e) {
        log(e.toString());
        emit(AddDeliveryFailure());
      }
    });
  }
}
