import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_my_user_event.dart';
part 'get_my_user_state.dart';

class GetMyUserBloc extends Bloc<GetMyUserEvent, GetMyUserState> {
  final UserRepository _userRepository;
  GetMyUserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(GetMyUserState.loading()) {
    on<GetMyUser>((event, emit) async {
      ;
      try {
        MyUser? user = await _userRepository.getMyUser(event.userId);
        emit(GetMyUserState.success(user));
      } catch (e) {
        log(e.toString());
        emit(const GetMyUserState.failure());
      }
    });
  }
}
