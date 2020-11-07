import 'dart:convert';
import 'dart:html';

import 'package:carros/src/model/login.dart';
import 'package:http/http.dart';

class LoginService {

  Login _loginUsuario = Login();

  Client http2;

  LoginService(){
    http2 = Client();
  }

  var headers = {'contente-type':'application/jason'};

  bool EstaLogado(){
    if(_loginUsuario.token == null){
      return false;
    }
    return true;
  }


  bool ManterConectado(){
    return window.localStorage['USER_WEBCARS'] == null ? false : true;
  }

  void Desconectar(){
    window.localStorage.remove('USR_WEBCARS');
  }

  String LoginString(){
    return _loginUsuario.toJson();
  }


  Future<Map<String, dynamic>> Logar(String usuario, String senha) async {

    try{
      var urlLogin = 'http://carros-springboot.herokuapp.com/api/v2/login';

      var body ={'username':usuario, 'password':senha};

      var response = await http2.post(urlLogin, headers: headers, body: json.encode(body));

      
      

      if(response.statusCode == 200){
        _loginUsuario = Login.fromJson(response.body);
        return {'codigo ': 0, 'mensagem' : 'Login realizado com sucesso'};
      }else {
        return {'codigo ': 1, 'mensagem' : 'usuario ou senha invalidos'};
      }

    } catch(e){
      return {'codigo ': 1, 'mensagem' : 'Falha ao acessar sistema'};
    }

    


  }
}