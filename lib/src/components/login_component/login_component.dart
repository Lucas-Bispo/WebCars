
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:carros/src/routes/routes.dart';
import 'package:carros/src/services/login_service.dart';

@Component(
  selector: 'login',
  styleUrls: ['login_component.css'],
  templateUrl: 'login_component.html',
  directives: [coreDirectives, formDirectives]
)
class LoginComponent extends OnInit{

  Router _router;

  LoginService _loginService;

  var usuario = '';

  var senha = '';

  var switchConectado = false;

  LoginComponent(this._router, this._loginService);

  void Logar()async{
    var resposta = await _loginService.Logar(usuario, senha);
    if (resposta['codigo'] == 0){
      if (switchConectado == true){
        window.localStorage['USR_WEBCARS']=_loginService.LoginString();
        print (window.localStorage['USR_WEBCARS']);
      }
      _router.navigate(RoutePaths.painel.toUrl());
    }else{
      var elementoAlerta = document.getElementById('alert-erro');
      MostraMensagemAlerta(elementoAlerta,resposta['mensagem']);
    }    
  }

  void MostraMensagemAlerta(Element element, String mensagem) async{
    element.style.display = 'block';
    element.text = mensagem;
    await Future.delayed(Duration(seconds: 3));
    element.style.display = 'none';
  }

  @override
  void ngOnInit() {
    // TODO: implement ngOnInit
    if(_loginService.ManterConectado() == true) _router.navigate(RoutePaths.painel.toUrl());    
  } 
}
