import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_component_event.dart';
part 'login_component_state.dart';

class LoginComponentBloc extends Bloc<LoginComponentEvent, LoginComponentState> {
  LoginComponentBloc() : super(LoginComponentInitial());

  @override
  Stream<LoginComponentState> mapEventToState(
    LoginComponentEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
