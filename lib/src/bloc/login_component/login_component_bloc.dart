import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carros/src/services/login_service.dart';
import 'package:meta/meta.dart';

part 'login_component_event.dart';
part 'login_component_state.dart';

class LoginComponentBloc extends Bloc<LoginComponentEvent, LoginComponentState> {

  final String _usuario, _senha;

  final LoginService _loginService;

  LoginComponentBloc(this._usuario, this._senha, this._loginService) : super(LoginComponentInitial(_usuario, _senha, 'Usuário inicializado'));

  @override
  Stream<LoginComponentState> mapEventToState(
    LoginComponentEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoginComponentEventLogar){
      var usuario = event.props[0];
      var senha = event.props[1];
      yield* mapLogar(usuario, senha);
    }
  }

  Stream<LoginComponentState> mapLogar(String usuario, String senha) async* {

    yield LoginComponentLogando(usuario, senha, 'Usuario Logando no SIstema');

    var resposta = await _loginService.Logar(usuario, senha);

    if (resposta['codigo'] == 0){
      yield LoginComponentLogado(usuario, senha, 'Usuario Logado com Sucesso');
    }else{
      yield LoginComponentNaoLogado(usuario, senha, 'Usuário e/ou Senha inválidos!');
    }       

  }



}
