import 'package:angular/angular.dart';
import 'package:carros/src/model/carro.dart';
import 'package:carros/src/services/carro_service.dart';
import 'dart:async';

@Component(
  selector: 'tabela',
  templateUrl: 'tabela_component.html',
  styleUrls: ['tabela_component.css'],
  directives: [coreDirectives]
)
class TabelaComponent extends OnInit{

  final CarroService _carroServico;

  List<Carro> listaCarros;

  List<Carro> listaCarros2;

  TabelaComponent(this._carroServico);

  @override
  void ngOnInit() async {
    // TODO: implement ngOnInit
    listaCarros = await _carroServico.GetListaCarros2();
    //listaCarros2 = await _carroServico.GetListaCarros2();
    _carroServico.streamCarro.listen((carro) { 
      print ('[TABELA_COMPONENT] O Carro ' + carro.nomeCarro + 'foi recebido no fluxo.');
    });   
    _carroServico.streamListaCarro.listen((listaCarroPesquisa) { 
      listaCarros = listaCarroPesquisa;
    });  
  }

  void DeletarCarro(Carro carro){
    _carroServico.DeletarCarro(carro);
  }  

  void SelecionarCarro(Carro carro){
    _carroServico.SelecionarCarro(carro);
  }

}
