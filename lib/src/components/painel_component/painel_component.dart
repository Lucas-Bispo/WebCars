import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:carros/src/routes/route_paths.dart';
import 'package:carros/src/services/login_service.dart';
import '../cadastro_component/cadastro_component.dart';
import '../navbar_component/navbar_component.dart';
import '../tabela_component/tabela_component.dart';

@Component(
  selector: 'painel',
  styleUrls: ['painel_component.css'],
  templateUrl: 'painel_component.html',
  directives: [coreDirectives, CadastroComponent, NavbarComponent, TabelaComponent],
)
class PainelComponent extends OnInit{

  LoginService _loginService;

  Router _router;

  PainelComponent(this._loginService, this._router);

  @override
  void ngOnInit(){
    if(_loginService.EstaLogado() == false){
      _router.navigate(RoutePaths.login.toUrl());
    }
  }
  
}
