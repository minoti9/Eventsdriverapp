import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable{
  AuthenticationState([List ls=const[]]);
}

  class AuthenticationAuthenticated extends AuthenticationState {
    AuthenticationAuthenticated();

  @override
  String toString() => 'AuthenticationAuthenticated';

  @override
  List<Object> get props => throw UnimplementedError();
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';

  @override
  List<Object> get props => throw UnimplementedError();
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';

  @override
  List<Object> get props => throw UnimplementedError();
}




