import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import '../model/carro.dart';


class InMemoryDataService extends MockClient {
static final _initialCarros = [
    {'codigoCarro':1,'nomeCarro':'Gol GTI','nomeFabricante':'Volksvagem','anoFabricacao':1994,'preco':15000.20,'imagem':'https://quatrorodas.abril.com.br/wp-content/uploads/2018/11/gol-gti-modelo-1989-da-volkswagen-de-propriedade-do-publicitc3a1rio-rafael-carmin_1.jpg?quality=70&strip=info'},
    {'codigoCarro':2,'nomeCarro':'Scort XR3','nomeFabricante':'Ford','anoFabricacao':1995,'preco':18000.20,'imagem':'https://quatrorodas.abril.com.br/wp-content/uploads/2019/06/qr-721-classicos-xr3-01.tif_-e1559850002131.jpg?quality=70&strip=info'},
    {'codigoCarro':3,'nomeCarro':'Apolo','nomeFabricante':'Volksvagem','anoFabricacao':1997,'preco':17200.20,'imagem':'https://quatrorodas.abril.com.br/wp-content/uploads/2016/11/56be66f80e21630a3e127f80qr-667-grandes-brasileiros-02-psd.jpeg?quality=70&strip=all&strip=all'},
    {'codigoCarro':4,'nomeCarro':'Verona','nomeFabricante':'Ford','anoFabricacao':1998,'preco':18300.20,'imagem':'https://combustivel.app/imgs/t650/consumo-verona-lx-1-6.jpg'},
  ];
  static List<Carro> _carroDb;
  static int _nextCodigo;

  static Future<Response> _handler(Request request) async {
    if (_carroDb == null) resetLista();
    var data;  
    switch (request.method) {
      case 'GET':
        final codigo = int.tryParse(request.url.pathSegments.last);
        if (codigo != null) {
          data = _carroDb
              .firstWhere((carro) => carro.codigoCarro == codigo); // throws if no match
        } else {
          var prefix = request.url.queryParameters['nomeCarro'] ?? '';
          final regExp = RegExp(prefix, caseSensitive: false);
          data = _carroDb.where((carro) => carro.nomeCarro.contains(regExp)).toList();
        } 
        break;

      case 'POST':
        var carroMap =json.decode(request.body)['carro'];
        var novoCarro = Carro.fromMap(carroMap);
        novoCarro.codigoCarro = _nextCodigo++;
        _carroDb.add(novoCarro);
        data = _carroDb;
        break;

      case 'PUT':
        var carroAlteracaoMap = json.decode(request.body);
        var carroAlteracao = Carro.fromMap(carroAlteracaoMap);
        var carroTarget = _carroDb.firstWhere((carro) => carro.codigoCarro == carroAlteracao.codigoCarro);

        carroTarget.CloneCarro(carroAlteracao);
        data = _carroDb;



        break;
      case 'DELETE':
        data = null;
        break;
      default:
        throw 'Método HTTP não implementado ${request.method}';
    }   
    return Response(json.encode({'data': data}), 200,
        headers: {'content-type': 'application/json'});       
  }

  static resetLista() {
    _carroDb = _initialCarros.map((carroJson) => Carro.fromMap(carroJson)).toList();
    _nextCodigo = _carroDb.map((carro) => carro.codigoCarro as int).fold(0, max) + 1;
  }  

  InMemoryDataService() : super(_handler);
}
