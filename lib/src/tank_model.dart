class TankModel{
  int no,tds,level,usage,turbiudity;
  bool issue;
  String email,area;
  TankModel(String tds,String turbiudity,String level,String usage,bool issue,String email,String area,String no){
    this.no = int.parse(no);
    this.tds = int.parse(tds);
    this.turbiudity = int.parse(turbiudity);
    this.level = int.parse(level);
    this.usage = int.parse(usage);
    this.issue = issue;
    this.email = email;
    this.area = area ;
    print("succesfull");
  }
  // ignore: non_constant_identifier_names
  TankModel.Parsed(int tds,int turbiudity,int level,int usage,bool issue,String email,String area,int no){
    this.no = no;
    this.tds = tds;
    this.turbiudity = turbiudity;
    this.level = level;
    this.usage = usage;
    this.issue = issue;
    this.email = email;
    this.area = area;
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
    print("succesfull");
  }
}