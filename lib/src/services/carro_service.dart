import 'dart:async';
import 'dart:convert';
import 'package:carros/src/model/carro.dart';
import 'package:http/http.dart';

import 'package:stream_transform/stream_transform.dart';

class CarroService{

  StreamController<Carro> streamControllerCarro = StreamController<Carro>.broadcast();

  StreamController<String> streamControllerPesquisa = StreamController<String>.broadcast();

  StreamController<List<Carro>> streamControllerListaCarro = StreamController<List<Carro>>.broadcast();

  Stream<Carro> streamCarro;

  Stream<String> streamPesquisa;

  Stream<List<Carro>> streamListaCarro;

  static const _carrosUrl = 'api/carros'; // URL to web API

  final Client _http;  

  static final _headers ={'Content-Type': 'application/jason'};

  CarroService(this._http){
    streamCarro = streamControllerCarro.stream;
    streamPesquisa = streamControllerPesquisa.stream
      .debounce(Duration(microseconds: 300))
      .distinct();
    streamListaCarro = streamControllerListaCarro.stream;
    streamPesquisa.listen((termo) async{ 
      

      var listaCarroPesquisa = await pesquisaCarros(termo);
      streamControllerListaCarro.add(listaCarroPesquisa);
    });
  }
  //teste

  Future<List<Carro>> pesquisaCarros(termo) async {
    try {
      final pesquisaCarrosUrl = '${_carrosUrl}/?nomeCarro={termo}';
      final response = await _http.get(pesquisaCarrosUrl);
      final carros = _extractData(response);
          
      return carros;
    } catch (e) {
      throw _handleError(e);
    }
  }

  void SelecionarCarro(Carro carro) async {
    final selecionaCarrosUrl = '${_carrosUrl}/${carro.codigoCarro}';
    final response = await _http.get(selecionaCarrosUrl);
    final carroMap = json.decode(response.body)['data'];
    final carrosSelecionado =Carro.fromMap(carroMap);
    
    streamControllerCarro.add(carro);
  }



  List<Carro> listaCarros = [
    Carro(3, 'Gol GTI', 'Volksvagem', '1994', 15000.20,'https://quatrorodas.abril.com.br/wp-content/uploads/2018/11/gol-gti-modelo-1989-da-volkswagen-de-propriedade-do-publicitc3a1rio-rafael-carmin_1.jpg?quality=70&strip=info'),
    Carro(2, 'Scort XR3', 'Ford', '1995', 16500.20,'https://quatrorodas.abril.com.br/wp-content/uploads/2019/06/qr-721-classicos-xr3-01.tif_-e1559850002131.jpg?quality=70&strip=info'),
    Carro(1, 'Apolo', 'Volksvagem', '1997', 17000.20,'https://quatrorodas.abril.com.br/wp-content/uploads/2016/11/56be66f80e21630a3e127f80qr-667-grandes-brasileiros-02-psd.jpeg?quality=70&strip=all&strip=all'),
    Carro(4, 'Verona', 'Ford', '1998', 18300.20,'https://combustivel.app/imgs/t650/consumo-verona-lx-1-6.jpg'),
  ];

  int RetornaProxCodigo(){
    listaCarros.sort((carroa, carrob) => carroa.codigoCarro.compareTo(carrob.codigoCarro));
    return listaCarros.last.codigoCarro + 1;
  }
  
  List<Carro> GetListaCarros(){
    return listaCarros;    
  }

  Future<List<Carro>> GetListaCarros2()async{
    try {
      final response = await _http.get(_carrosUrl);
      final carros = _extractData(response);
          
      return carros;


    } catch (e) {
      throw _handleError(e);
    }   
  }

  dynamic _extractData(Response resp) => 
  (json.decode(resp.body)['data'] as List)
  .map((carro) => Carro.fromMap(carro))
  .toList();


  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return Exception('Server error; cause: $e');
  }  

 Map<String,String> CadastrarCarro(Carro carro){
    carro.codigoCarro = RetornaProxCodigo();
    try{
      listaCarros.add(carro); 
      return {'codigo':'0', 'mensagem':'Carro cadastrado com sucesso!'};
    }catch(e){
      return {'codigo':'-1', 'mensagem':'Erro ao tentar cadastrar o carro:' + e};
    }    
  }

  Future<Map<String,String>> CadastrarCarro2(Carro carro) async{
    
    try{
     final response = await _http.post(_carrosUrl,
      headers: _headers, body: json.encode({'carro': carro}));
      final listaCarrosAtualizada = _extractData(response);
      streamControllerListaCarro.add(listaCarrosAtualizada);
      return {'codigo':'0', 'mensagem':'Carro cadastrado com sucesso!'};
    }catch(e){
      return {'codigo':'-1', 'mensagem':'Erro ao tentar cadastrar o carro:' + e};
    }    
  }




  void DeletarCarro(Carro carro){
    listaCarros.remove(carro);
    streamControllerCarro.add(carro);
  }

  Map<String,String> AlterarCarro(Carro carroCadastro) {
    try{
      var carroAtual = listaCarros.firstWhere((carro) => carro.codigoCarro == carroCadastro.codigoCarro);
      CloneCarro(carroAtual, carroCadastro);      
      return {'codigo':'0', 'mensagem':'Carro alterado com sucesso!'};
    }catch(e){
      return {'codigo':'-1', 'mensagem':'Erro ao tentar alterar o carro:'};
    }      
  }
  Future<Map<String,String>> AlterarCarro2(Carro carroAlteracao) async{
    try{
      final url = '${_carrosUrl}/${carroAlteracao.codigoCarro}';
      
      final response = 
        await _http.put(url, headers:  _headers, body: json.encode(carroAlteracao));
      final listaCarrosAtualizada = _extractData(response);
      streamControllerListaCarro.add(listaCarrosAtualizada);

      return {'codigo':'0', 'mensagem':'Carro alterado com sucesso!'};
    }catch(e){
      return {'codigo':'-1', 'mensagem':'Erro ao tentar alterar o carro:'};
    }      
  }

  void CloneCarro(Carro carroAtual, Carro carroNovo){
    carroAtual.anoFabricacao = carroNovo.anoFabricacao;
    carroAtual.imagem = carroNovo.imagem;
    carroAtual.nomeFabricante = carroNovo.nomeFabricante;
    carroAtual.preco = carroNovo.preco;
    carroAtual.nomeCarro = carroNovo.nomeCarro;
  }

}
