part of 'get_my_user_bloc.dart';

sealed class GetMyUserEvent extends Equatable {
  const GetMyUserEvent();

  @override
  List<Object> get props => [];
}

class GetMyUser extends GetMyUserEvent {
  final String userId;
  const GetMyUser({required this.userId});
}
