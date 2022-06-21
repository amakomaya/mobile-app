class LoginRequestModel{

  String username;
  String password;

  LoginRequestModel({ required this.username,required this.password,});
 Map<String, dynamic> toJson() => <String, dynamic>{
        'username':username,
        'password': password,
       
      };

}