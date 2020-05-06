import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firestore db = Firestore.instance;

  /*

  db
  .collection("usuarios")
  .document("002")
  .setData({"nome": "Priscila Cardoso", "idade": "30"});
  
  
  DocumentReference ref = await db.collection("noticias")
  .add({
    "titulo" : "Ondas de calor em São Paulo",
    "descricao" : "Descricao para Ondas de calor em São Paulo",
  });

  print("Item Salvo " + ref.documentID);


  db.collection("noticias").document("ciI12CVhMBoWJ6omHFyz").setData({
    "titulo": "[ALTERADO] Ondas de calor em São Paulo",
    "descricao": "Descricao para Ondas de calor em São Paulo",
  });


  //db.collection("usuarios").document("003").delete();

  DocumentSnapshot snapshot = await db.collection("usuarios").document("002").get();

  var dados = snapshot.data;
  var id = snapshot.documentID;

  print(snapshot.data.toString());

  print("ID: " + id.toString() + " - Dados: "+ dados["nome"] + " - Idade: " + dados["idade"]);




  QuerySnapshot querySnapshot = await db.collection("usuarios").getDocuments();

  for(DocumentSnapshot item in querySnapshot.documents){
    var dados = item.data;
    var ids = item.documentID;
    print("Id -> "+ ids.toString() + " Dados -> " + dados["nome"] + " - Idade -> " + dados["idade"]);
  }


    // Listen
    db.collection("usuarios").snapshots().listen(
      (snapshot){
        for(DocumentSnapshot item in snapshot.documents){
          var dados = item.data;
          var ids = item.documentID;
          print("Id -> "+ ids.toString() + " Dados -> " + dados["nome"] + " - Idade -> " + dados["idade"]);
        }
      }
  );


  var pesquisa = "ma";

  // Filtros
  QuerySnapshot querySnapshot = await db
      .collection("usuarios")
      //.where("nome", isEqualTo: "leonardo")
      //.where("idade", isEqualTo: "38")
      //.where("idade", isEqualTo: 30)
      //.where("idade",
         // isGreaterThanOrEqualTo:
          //    23) // (isLessThan menor que | isLessThanOrEqualTo ) > maior >= maior ou igual
      //.where("idade", isLessThan: 50)
      //.orderBy("idade", descending: true)
      //.orderBy("nome", descending: false)
      //.limit(3)
      .where("nome", isGreaterThanOrEqualTo: pesquisa)
      .where("nome", isLessThanOrEqualTo: pesquisa + "\uf8ff")
      .getDocuments();

  for (DocumentSnapshot item in querySnapshot.documents) {
    var dados = item.data;
    print("filtro: nome: ${dados["nome"]} idade: ${dados["idade"]}");
  }

   */

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
