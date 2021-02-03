import 'dart:convert';

// class User{
//   String email;
//   String password;
//   User();
//   User.withDetails(String email,String password){
//     this.email = email;
//     this.password = password;
//   }
// }

class UserLogin extends User{

}

class LoginResponse{
  String token;
  String name;
  String role;
  bool status;

  LoginResponse({this.token,this.name,this.role,this.status});
  LoginResponse.withoutRole({this.token,this.name,this.status});
  LoginResponse.fromJson(parsedJson){
    token = parsedJson['token'];
    name = parsedJson['name'];
    role = parsedJson['role'];
    if(parsedJson['status'] == 'ok')
      status = true;
    else
      status = false;  
  }
}

class User{
  String id,firstname,lastname,contact,address,area,email;
  int tanks;
  
}
