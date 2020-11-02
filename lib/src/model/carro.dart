import 'dart:convert';

class Carro{
  var codigoCarro;
  var nomeCarro;
  var nomeFabricante;
  var anoFabricacao;
  var preco;
  var imagem;

  Carro(this.codigoCarro, this.nomeCarro, this.nomeFabricante, this.anoFabricacao, this.preco, this.imagem);

    factory Carro.fromJson(String jason) => Carro.fromMap(json.decode(jason));
    
    factory Carro.fromMap(Map<String, dynamic> carro) =>
    Carro(_toInt(carro['codigoCarro']),carro['nomeCarro'],carro['nomeFabricante'], _toInt(carro['anoFabricacao']), _toDouble(carro['preco']), carro['imagem']);

    Map<String, dynamic> toJson() =>
    {'codigoCarro':codigoCarro, 'nomeCarro':nomeCarro, 'nomeFabricante':nomeFabricante, 'anoFabricacao':anoFabricacao, 'preco':preco, 'imagem':imagem};


}
    
int _toInt(number) => number is int ? number : int.parse(number);

double _toDouble(number) => number is double ? number : double.parse(number);
