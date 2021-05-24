import 'package:shared_preferences/shared_preferences.dart';

Future<bool> savedToken(String token) async {
  print("share Token:$token");
  SharedPreferences preftoken = await SharedPreferences.getInstance();
  preftoken.setString("token", token);
  // ignore: deprecated_member_use
  return preftoken.commit();
}

Future<String> getToken() async {
  SharedPreferences preftoken = await SharedPreferences.getInstance();
  String token = preftoken.getString("token");
  return token;
}

Future<bool> isLogged()async{
  SharedPreferences isLoggedIn = await SharedPreferences.getInstance();
  return isLoggedIn.getBool('isLogged');
}

Future<bool> setLogin(bool flag)async{
  SharedPreferences isLoggedIn = await SharedPreferences.getInstance();
  isLoggedIn.setBool('isLogged', flag);
  // ignore: deprecated_member_use
  return isLoggedIn.commit();
}

