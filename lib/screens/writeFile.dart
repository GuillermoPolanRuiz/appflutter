import 'dart:io';
import 'dart:convert';

class WriteFile {
  final Player player;

  WriteFile(this.player);


  List<Player> players = [];

  void main() async{
      print("hello world");
      final File file = File('assets/save.json'); //load the json file
      await readPlayerData(file); //read data from json file

    players.add(player);

    print(players.length);

    players  //convert list data  to json 
        .map(
          (player) => player.toJson(),
        )
        .toList();
        
      file.writeAsStringSync(json.encode(players));  //write (the whole list) to json file
  }

  Future<void> readPlayerData (File file) async { 
    
      
      String contents = await file.readAsString();
      var jsonResponse = jsonDecode(contents);
      
      for(var p in jsonResponse){
          
          Player player = Player(p['id'],p['name'],p['desc'],p['image'],p['cor1'],p['cor2'],p['es']);
          players.add(player);
      }
      
        
  }
}

class Player {
  late String id;
  late String name;
  late String desc;
  late String image;
  late String cor1;
  late String cor2;
  late String es;
  

  Player(
    this.id,
     this.name,
     this.desc,
    this.image,
    this.cor1,
    this.cor2,
    this.es,
  );

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    image = json['image'];
    cor1 = json['cor1'];
    cor2 = json['cor2'];
    es = json['es'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.desc;
    data['image'] = this.image;
    data['cor1'] = this.cor1;
    data['cor2'] = this.cor2;
    data['es'] = this.es;

    return data;
  }
  
}