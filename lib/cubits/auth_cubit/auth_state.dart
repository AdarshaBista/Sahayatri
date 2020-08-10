part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class Authenticated extends AuthState {
  final User user;

  const Authenticated({
    @required this.user,
  }) : assert(user != null);

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
