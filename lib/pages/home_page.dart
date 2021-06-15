



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_topico/models/user.dart';
import 'package:firebase_topico/providers/BD/db_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

     TextEditingController tcontrollerCI , tcontrollerNc , tcontrollerAc, tcontrollerC , tcontrollerCiudad;
     FirebaseFirestore fireStoreInstance;

     initState(){
        this.fireStoreInstance = FirebaseFirestore.instance;
        Dbprovider.db.initDB();
        this.tcontrollerCI = new TextEditingController( text: "" );
        this.tcontrollerNc = new TextEditingController( text:"");
        this.tcontrollerAc = new TextEditingController( text: "" );

     } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
            title: Text("FireStore Database"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                    children: [
                         
                          TextField(
                               controller:  this.tcontrollerCI,
                               decoration: InputDecoration(
                                    hintText: "Carnet de identidad",
                                    
                               ),
                               keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 25,),
                          TextField(
                               controller:  this.tcontrollerNc,
                               decoration: InputDecoration(
                                    hintText: "Nombre completo",
                               ),
                          ),
                          SizedBox(height: 25,),
                          TextField(
                               controller:  this.tcontrollerAc,
                               decoration: InputDecoration(
                                    hintText: "Apellido Completo",
                               ),
                          ),
                         
                          SizedBox( height: 30 ),

                          MaterialButton(
                              minWidth: 200.0,
                              height: 40.0,
                              elevation: 20.0,
                              onPressed: () async {
                                
                                    Usuario nuevoUsuario = Usuario( ci: this.tcontrollerCI.text , nombreCompleto : this.tcontrollerNc.text , apellidoCompleto: this.tcontrollerAc.text 
                                     ); 

                                  this.fireStoreInstance.collection('Usuarios').where('ci' , isEqualTo: nuevoUsuario.ci )
                                        .get().then((value) {
                                              //print(value.docs.length);
                                              if( value.docs.length > 0 ){
                                                final snackBar = SnackBar(content: Text('Usuario ya registrado'));
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar); 
                                              }else{

                                                  this.fireStoreInstance.collection('Usuarios').add(nuevoUsuario.toJson())
                                                      .then((value) {
                                                           final snackBar = SnackBar(content: Text('Usuario registrado exitosamente'));
                                                           ScaffoldMessenger.of(context).showSnackBar(snackBar);  
                                                      })
                                                      .onError((error, stackTrace) {
                                                             final snackBar = SnackBar(content: Text('Ocurrio un error al registrar usuario'));
                                                             ScaffoldMessenger.of(context).showSnackBar(snackBar);   
                                                      });

                                              }
                                        });


                              },
                              color: Colors.green,
                              child: Text('Enviar', style: TextStyle(color: Colors.white)),
                            ),
                          

                    ],
              ),
            ),
          ),
    );
  }
}