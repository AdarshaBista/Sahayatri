part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends UserState {
  const AuthLoading();
}

class Unauthenticated extends UserState {
  const Unauthenticated();
}

class Authenticated extends UserState {
  final User user;

  const Authenticated({
    @required this.user,
  }) : assert(user != null);

  @override
  List<Object> get props => [user];
}

class AuthError extends UserState {
  final String message;

  const AuthError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
