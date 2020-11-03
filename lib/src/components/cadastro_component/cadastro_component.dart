import 'dart:html';

import 'package:angular/angular.dart';
import 'package:carros/src/model/carro.dart';
import 'package:carros/src/services/carro_service.dart';
import 'package:angular_forms/angular_forms.dart';


@Component(
  selector: 'cadastro',
  templateUrl: 'cadastro_component.html',
  styleUrls: ['cadastro_component.css'],
  directives: [coreDirectives, formDirectives]
)
class CadastroComponent extends OnInit{

  final CarroService _carroService;

  var listaCarros;

  @override
  void ngOnInit() {
    // TODO: implement ngOnInit
    _carroService.streamCarro.listen((carro) { 
      AlternaBotaoAlterar('ativar');
      carroCadastro = carro;
    });    
  }  

  Carro carroCadastro = Carro(0, null, null, null, null, null);

  CadastroComponent(this._carroService);

  void CadastrarCarro()async {
    var elementoAlerta;
    var retornoCadastro = await _carroService.CadastrarCarro2(carroCadastro);
    if (retornoCadastro['codigo'] == '0'){
      elementoAlerta = document.getElementById('alert-sucesso');
    } else{
      elementoAlerta = document.getElementById('alert-erro');
    }
    MostraMensagemAlerta(elementoAlerta,retornoCadastro['mensagem']);
  }

  void AlterarCarro(){
    var elementoAlerta;
    var retornoAlteracao = _carroService.AlterarCarro(carroCadastro);
    if (retornoAlteracao['codigo'] == '0'){
      elementoAlerta = document.getElementById('alert-sucesso');
    } else{
      elementoAlerta = document.getElementById('alert-erro');
    }
    MostraMensagemAlerta(elementoAlerta,retornoAlteracao['mensagem']);     
  }

  void AlternaBotaoAlterar(String acao){
    ButtonElement botaoCadastrar = document.getElementById('btn-cadastrar');
    ButtonElement botaoAlterar = document.getElementById('btn-alterar');
    if (acao == 'ativar'){
      botaoCadastrar.style.display = 'none';
      botaoAlterar.style.display = 'inline-block';
    } else{
      botaoCadastrar.style.display = 'inline-block';
      botaoAlterar.style.display = 'none';
    }
  }

  void MostraMensagemAlerta(Element element, String mensagem) async{
    element.style.display = 'block';
    element.text = mensagem;
    await Future.delayed(Duration(seconds: 3));
    element.style.display = 'none';
    LimparCampos();
  }

  void LimparCampos(){
    AlternaBotaoAlterar('desativar');
    carroCadastro = Carro(null, null, null, null, null, null);
  }



 
   
}
