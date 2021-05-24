class CookieHolder{
  static String _cookie;
  static void updateCookie(String newCookie){
    _cookie=newCookie;
  }
  static String getCookie(){
    return _cookie;

  }
}