part of 'login_component_bloc.dart';

@immutable
abstract class LoginComponentState {
  final String _usuario;
  
  final String _senha;

  final String _mensagem;

  const LoginComponentState(this._usuario, this._senha, this._mensagem);

  @override
  List<Object> get props => [_usuario, _senha, _mensagem];   

}

class LoginComponentInitial extends LoginComponentState {
  const LoginComponentInitial(usuario, senha, mensagem) : super(usuario, senha, mensagem);

  @override
  List<Object> get props => [_usuario, _senha, _mensagem];    
}

class LoginComponentLogando extends LoginComponentState {
  const LoginComponentLogando(usuario, senha, mensagem) : super(usuario, senha, mensagem);

  @override
  List<Object> get props => [_usuario, _senha, _mensagem];    

}

class LoginComponentLogado extends LoginComponentState {
  const LoginComponentLogado(usuario, senha, mensagem) : super(usuario, senha, mensagem);

  @override
  List<Object> get props => [_usuario, _senha, _mensagem];    
}

class LoginComponentNaoLogado extends LoginComponentState {
  const LoginComponentNaoLogado(usuario, senha, mensagem) : super(usuario, senha, mensagem);

  @override
  List<Object> get props => [_usuario, _senha, _mensagem];  
}

