import 'dart:convert';
import 'dart:html';

import 'package:carros/src/model/login.dart';
import 'package:http/http.dart';

class LoginService {

  Login loginUsuario;

  Client http2;

  LoginService(){
    http2 = Client();
  }

  var headers = {'contente-type':'application/jason'};

  Future<Map<String, dynamic>> Logar(String usuario, String senha) async {

    try{
      var urlLogin = 'http://carros-springboot.herokuapp.com/api/v2/login';

      var body ={'username:${usuario}, password${senha}'};

      var response = await http2.post(urlLogin, headers: headers, body: json.encode(body));

      loginUsuario = Login.fromJson(response.body);
      

      if(response.statusCode == '200'){
        return {'codigo ': 200, 'mensagem' : 'Login realizado com sucesso'};
      }else {
        return {'codigo ': 401, 'mensagem' : 'usuario ou senha invalidos'};
      }

    } catch(e){
      return {'codigo ': 401, 'mensagem' : 'Falha ao acessar sistema'};
    }

    


  }
}