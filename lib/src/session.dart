import 'package:http/http.dart';
class Session{
  static Map <String,String>myheader={};
  static String rawCookie;
  Future<Response> getRequest(String url) async{
    Response res = await get(url,headers: myheader);
    updateCookie(res);
    return res;
    
  } 

  Future<Response> postRequest(String url,dynamic data) async{
    Response res= await post(url,body:data,headers:myheader);
    updateCookie(res);
    return res;

  }

  void updateCookie(Response res){
    rawCookie = res.headers['set-cookie'];
    if(rawCookie!=null){
      var cookie = (rawCookie.split(";")[0]);
      myheader['Cookie'] = cookie;
    }
    print(myheader);
  }
  /*
      var cookie = serverResponse.headers['set-cookie'];
      var cookie1 = (cookie.split(";")[0]);
      print(cookie);
      Map <String,String> cookieHeader =  { 
        "Cookie" : cookie1


  */
}
