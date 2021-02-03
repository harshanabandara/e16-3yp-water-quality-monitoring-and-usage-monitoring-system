class TankModel{
  int no,tds,level,usage,turbiudity;
  bool issue;
  String email,area;
 
  TankModel(String no,String tds,String turbiudity,String level,String usage,bool issue,String email,String area){
    this.no = int.parse(no);
    this.tds = int.parse(tds);
    this.turbiudity = int.parse(turbiudity);
    this.level = int.parse(level);
    this.usage = int.parse(usage);
    this.issue = issue;
    this.email = email;
    this.area = area ;
  }
  
  TankModel.fromJson(parsedJson){
    no = int.parse(parsedJson['no']);
    tds = int.parse( parsedJson['tds']);
    turbiudity = int.parse( parsedJson['turbiudity']);
    level = int.parse( parsedJson['level']);
    usage = int.parse( parsedJson['usage']);
    issue = parsedJson['issue'];
    email = parsedJson['email'];
    area = parsedJson['area'];
  }
}