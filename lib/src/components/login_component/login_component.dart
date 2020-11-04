import 'package:angular/angular.dart';

import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:carros/src/routes/routes.dart';

@Component(
  selector: 'login',
  styleUrls: ['login_component.css'],
  templateUrl: 'login_component.html',
  directives: [coreDirectives, formDirectives]
)
class LoginComponent{

  Router _router;

  var usuario = '';
  var senha = '';

  LoginComponent(this._router);

  void Logar(){
    _router.navigate(RoutePaths.painel.toUrl());
  }

}
