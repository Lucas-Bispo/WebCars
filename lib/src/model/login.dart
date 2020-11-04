import 'dart:convert';


class Login {
  var id;
  var login;
  var nome;
  var email;
  var urlFoto;
  var token;
  var roles;
  
  Login({
    this.id,
    this.login,
    this.nome,
    this.email,
    this.urlFoto,
    this.token,
    this.roles,
  });

  Login copyWith({
    var id,
    var login,
    var nome,
    var email,
    var urlFoto,
    var token,
    var roles,
  }) {
    return Login(
      id: id ?? this.id,
      login: login ?? this.login,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      urlFoto: urlFoto ?? this.urlFoto,
      token: token ?? this.token,
      roles: roles ?? this.roles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'nome': nome,
      'email': email,
      'urlFoto': urlFoto,
      'token': token,
      'roles': roles,
    };
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Login(
      id: map['id'],
      login: map['login'],
      nome: map['nome'],
      email: map['email'],
      urlFoto: map['urlFoto'],
      token: map['token'],
      roles: map['roles'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Login.fromJson(String source) => Login.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Login(id: $id, login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles)';
  }



}
