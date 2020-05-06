import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*
  Firestore db = Firestore.instance;

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



  // AUTENTIFICAÇÃO

  /*

  FirebaseAuth auth = FirebaseAuth.instance;

  String email = "leocardosodev@gmail.com";
  String senha = "123456";
/*

  auth.createUserWithEmailAndPassword(
      email: email,
      password: senha
  ).then((firebaseUser){
    print("Novo usuario: SUCESSO!! E-MAIL: " + firebaseUser.user.email);
  }).catchError((error){
    print("Novo usuário ERRO: " + error.toString());
  });

   */

  auth.signOut();
  

  auth.signInWithEmailAndPassword(
      email: email,
      password: senha
  ).then((firebaseUser){
    print("Login realizado com SUCESSO! E-MAIL: " + firebaseUser.user.email);
  }).catchError((error){
    print("Erro ao logar: " + error.toString());
  });



  FirebaseUser usuarioAtual = await auth.currentUser();
  if(usuarioAtual != null){
    print("Usuario logado " + usuarioAtual.email);
  }else{
    print('Usuario não está LOGADO');
  }
  
   */
  //runApp(App());

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));

}

/*

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

 */


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  File _imagem;
  String _statusUpload = "";
  String _imageURL = null;

  Future _recuperarImage(bool daCamera) async {

    File imagemSelecionada;
    if(daCamera){
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
    }else{
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _imagem = imagemSelecionada;
    });

  }

  Future _uploadImage() async {
    // Intanciando Firebase Storage
    FirebaseStorage storage = FirebaseStorage.instance;
    // Referenciar Arquivo
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz.child("fotos").child("foto1.jpg");

    // Fazer Upload do arquivo
    StorageUploadTask task = arquivo.putFile(_imagem);

    // Controlar Progresso do upload
    task.events.listen((StorageTaskEvent storageEvent){
      if(storageEvent.type == StorageTaskEventType.progress){
        setState(() {
          _statusUpload = "Em progresso";
        });
      }else if(storageEvent.type == StorageTaskEventType.success){
        setState(() {
          _statusUpload = "Upload Realizado com Sucesso!";
        });
      }
    });

    // Recuperar URL da imagem
    task.onComplete.then((StorageTaskSnapshot snapshot){
      _recuperarURLImage(snapshot);

    }).catchError((error){
      //
    });

  }

  Future _recuperarURLImage(snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    setState(() {
      _imageURL = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar uma imagem"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(_statusUpload),
            RaisedButton(
              child: Text("Camera"),
              onPressed: (){
                _recuperarImage(true);
              },
            ),
            RaisedButton(
              child: Text("Galeria"),
              onPressed: (){
                _recuperarImage(false);
              },
            ),
            _imagem == null
                ? Container()
                : Image.file(_imagem),
            _imagem == null
                ? Container()
                : RaisedButton(
                child: Text("Upload Storage"),
                onPressed: (){
                  _uploadImage();
                }
            ),
            _imageURL == null ? Container() : Image.network(_imageURL),
          ],
        ),
      ),
    );
  }
}

