import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openaiword/openai/api_key.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _wordController = TextEditingController();

  String result = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 600,
          width: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("very", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black),),
                SizedBox(height: 15,),
                Text("+", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _wordController,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black),
                    
                    decoration: InputDecoration(
                      //TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                      hintText: 'Dumb',
                      contentPadding: const EdgeInsets.all(10.0),
                      hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                MaterialButton(
                  minWidth: 90,
                  height: 40,
                  color: Colors.black,
                  child: Text("Result", style: TextStyle(color: Colors.white),),
                  onPressed: getResult,
                ),
                SizedBox(height: 30,),
                Text(result, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getResult() async {
      http.Response res = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $openAIApiKey',
      
      },
      body: jsonEncode({
        "model": "text-davinci-003",
        "prompt": "combine the word very with another adjective to find a more suitable adjective\n\nvery + cold = freezing\nvery + nice = charming\nvery + high = steep\nvery + shining = gleaming\nvery + ${_wordController.text} =",
        "temperature": 0.7,
        "max_tokens": 256,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0
      }),
    );

    if(res.statusCode == 200)
    {
      //final data = jsonDecode(res.body);
      String text = jsonDecode(res.body)["choices"][0]["text"];
      //print([data['choices']][0]['text']);
      //print(text);
      //print('Success');

      setState(() {
        result = text;
      });
    }
    return result;
  }   
}