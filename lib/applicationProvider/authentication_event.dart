import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List ls = const []]);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => throw UnimplementedError();
}

class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn { token: $token }';

  @override
  List<Object> get props => throw UnimplementedError();
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object> get props => throw UnimplementedError();
}

class GotoDashboardEvent extends AuthenticationEvent {
  @override
  String toString() => 'GotoDashboardEvent';

  @override
  List<Object> get props => throw UnimplementedError();
}
