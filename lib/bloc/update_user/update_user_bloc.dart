import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UserRepository _userRepository;
  UpdateUserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UpdateUserInitial()) {
    on<UpdateUser>((event, emit) async {
      emit(UpdateUserLoading());
      try {
        await _userRepository.setUserData(event.user);

        emit(UpdaterUserSuccess());
      } catch (e) {
        log(e.toString());
        emit(UpdaterUserFailure());
      }
    });
  }
}
