import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delivery_repository/delivery_repository.dart';
import 'package:equatable/equatable.dart';

part 'update_delivery_event.dart';
part 'update_delivery_state.dart';

class UpdateDeliveryBloc
    extends Bloc<UpdateDeliveryEvent, UpdateDeliveryState> {
  final DeliveryRepository _deliveryRepository;
  UpdateDeliveryBloc({required DeliveryRepository deliveryRepository})
      : _deliveryRepository = deliveryRepository,
        super(UpdateDeliveryInitial()) {
    on<UpdateDelivery>((event, emit) async {
      try {
        emit(UpdateDeliveryLoading());
        await _deliveryRepository.updateDelivery(event.delivery);
        emit(UpdateDeliverySuccess(event.delivery));
      } catch (e) {
        log(e.toString());
        emit(UpdateDeliveryFailure());
      }
    });
  }
}
