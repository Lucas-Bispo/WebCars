import 'package:angular/angular.dart';

import 'package:carros/src/components/cadastro_component/cadastro_component.dart';

import 'package:carros/src/services/carro_service.dart';
import 'package:carros/src/services/login_service.dart';

import 'src/components/navbar_component/navbar_component.dart';

import 'src/components/tabela_component/tabela_component.dart';

import 'src/components/login_component/login_component.dart';

import 'package:angular_router/angular_router.dart';

import 'src/routes/routes.dart';

import 'package:http/http.dart';

// AngularDart info: https://angulardart.dev
// Components info: https://angulardart.dev/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  exports: [RoutePaths, Routes],
  directives: [NavbarComponent, TabelaComponent, CadastroComponent, LoginComponent, routerDirectives],
  providers: [ClassProvider(CarroService), ClassProvider(LoginService)],
)
class AppComponent {
  // Nothing here yet. All logic is in TodoListComponent.

}
