import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AstroApi extends StatefulWidget {
  const AstroApi({Key? key}) : super(key: key);

  @override
  State<AstroApi> createState() => _AstroApiState();
}

class _AstroApiState extends State<AstroApi> {
  var url="https://type.fit/api/quotes";
  getData() async{
    var res=await http.get(Uri.parse(url));
    var data=json.decode(res.body);
    return data;
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var width=size.width;
    var height=size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("Motivation Talks",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, dynamic snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Container(
                      width: width*1,
                      height: height*0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 11,
                            offset: Offset(1,5),
                            color: Colors.blue,
                          ),
                          BoxShadow(
                            blurRadius: 11,
                            offset: Offset(-5,-5),
                            color: Colors.white,
                          ),
                        ],
                        color: Colors.blue.shade100,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:EdgeInsets.only(top: height*0.05,left: width*0.02),
                            child: Text("${snapshot.data[index]["text"]}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.pinkAccent,),),
                          ),
                          SizedBox(height: 30),
                          Text("Author : ${snapshot.data[index]["author"]}",style: TextStyle(color: Colors.black,fontSize:17),),
                        ],
                      ),
                    ),
                  );
                });
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}
