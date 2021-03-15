part of 'login_component_bloc.dart';

@immutable
abstract class LoginComponentEvent {
  final String _usuario;
  
  final String _senha;

  const LoginComponentEvent(this._usuario, this._senha);

  @override
  List<Object> get props => [_usuario, _senha];    
}

class LoginComponentEventLogar extends LoginComponentEvent {
  const LoginComponentEventLogar(usuario, senha) : super(usuario, senha);

  @override
  List<Object> get props => [_usuario, _senha];    
}
