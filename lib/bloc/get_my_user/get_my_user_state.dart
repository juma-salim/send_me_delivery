part of 'get_my_user_bloc.dart';

enum MyUserStatus { success, loading, failure }

class GetMyUserState extends Equatable {
  final MyUserStatus status;
  final MyUser? user;

  const GetMyUserState._({
    this.status = MyUserStatus.loading,
    this.user,
  });

  const GetMyUserState.loading() : this._();

  const GetMyUserState.success(MyUser user)
      : this._(status: MyUserStatus.success, user: user);

  const GetMyUserState.failure() : this._(status: MyUserStatus.failure);

  @override
  List<Object?> get props => [status, user];
}
