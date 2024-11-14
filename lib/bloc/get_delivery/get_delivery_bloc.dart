import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_repository/delivery_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_delivery_event.dart';
part 'get_delivery_state.dart';

class GetDeliveryBloc extends Bloc<GetDeliveryEvent, GetDeliveryState> {
  final DeliveryRepository _deliveryRepository;
  GetDeliveryBloc({required DeliveryRepository deliveryRepository})
      : _deliveryRepository = deliveryRepository,
        super(GetDeliveryInitial()) {
    on<GetDelivery>((event, emit) async {
      try {
        emit(GetDeliveryLoading());
        final delivery = await _deliveryRepository.getDeliveries(event.userId);
        for (var delivery in delivery) {
          print(
              'Delivery: ${delivery.deliveryNumber}, ${delivery.deliveryDate}, ${delivery.deliveryStatus}');
        }
        emit(GetDeliverySuccess(delivery));
      } on FirebaseException catch (e) {
        log(e.toString());
        emit(GetDeliveryFailure());
      } catch (e) {
        log(e.toString());
        emit(GetDeliveryFailure());
      }
    });
    on<SearchDelivery>((event, emit) async {
      try {
        emit(GetDeliveryLoading());
        final deliveries =
            await _deliveryRepository.searchDeliveries(event.query);
        emit(GetDeliverySuccess(deliveries));
      } on FirebaseException catch (e) {
        log(e.toString());
        emit(GetDeliveryFailure());
      } catch (e) {
        log(e.toString());
        emit(GetDeliveryFailure());
      }
    });
  }
}
