class User {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? refreshToken;
  String? userName;
  String? id;
  String? logtime;
  String? code;
  String? result;
  String? passtype;
  String? name;
  String? principal;
  String? idpc;
  String? roles;
  String? wcf;
  String? expires;
  String? issued;

  User(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.refreshToken,
      this.userName,
      this.id,
      this.logtime,
      this.code,
      this.result,
      this.passtype,
      this.name,
      this.principal,
      this.idpc,
      this.roles,
      this.wcf,
      this.expires,
      this.issued});

  User.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
    userName = json['userName'];
    id = json['id'];
    logtime = json['logtime'];
    code = json['code'];
    result = json['result'];
    passtype = json['passtype'];
    name = json['name'];
    principal = json['principal'];
    idpc = json['idpc'];
    roles = json['roles'];
    wcf = json['wcf'];
    expires = json['.expires'];
    issued = json['.issued'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['refresh_token'] = this.refreshToken;
    data['userName'] = this.userName;
    data['id'] = this.id;
    data['logtime'] = this.logtime;
    data['code'] = this.code;
    data['result'] = this.result;
    data['passtype'] = this.passtype;
    data['name'] = this.name;
    data['principal'] = this.principal;
    data['idpc'] = this.idpc;
    data['roles'] = this.roles;
    data['wcf'] = this.wcf;
    data['.expires'] = this.expires;
    data['.issued'] = this.issued;
    return data;
  }
}
