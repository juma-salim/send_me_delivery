part of 'update_user_bloc.dart';

sealed class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object> get props => [];
}

final class UpdateUser extends UpdateUserEvent {
  final MyUser user;

  const UpdateUser(this.user);

  @override
  List<Object> get props => [user];
}
