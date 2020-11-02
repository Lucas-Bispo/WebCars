import 'package:angular/angular.dart';
import '../cadastro_component/cadastro_component.dart';
import '../navbar_component/navbar_component.dart';
import '../tabela_component/tabela_component.dart';

@Component(
  selector: 'painel',
  styleUrls: ['painel_component.css'],
  templateUrl: 'painel_component.html',
  directives: [coreDirectives, CadastroComponent, NavbarComponent, TabelaComponent],
)
class PainelComponent {
  
}
