import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:carros/src/routes/route_paths.dart';
import 'package:carros/src/services/carro_service.dart';

@Component(
  selector: 'navbar',
  templateUrl: 'navbar_component.html',
  styleUrls: ['navbar_component.css']
)
class NavbarComponent {

  final CarroService _carroService;

  Router _router;

  NavbarComponent(this._carroService, this._router);

  void PesquisarCarro(String termo){
    print(termo);
    _carroService.streamControllerPesquisa.add(termo);
  }

  void Login(){
    _router.navigate(RoutePaths.login.toUrl());
  }

}
