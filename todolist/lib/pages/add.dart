import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AddPage extends StatefulWidget {
  const AddPage({ Key? key }) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มรายการใหม่'),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            
            TextField(
                    controller: todo_title,
                    decoration: InputDecoration(
                        labelText: 'รายการที่ต้องทำ', 
                        border: OutlineInputBorder())),
            SizedBox(height: 30,),
            TextField(
                    minLines: 4,
                    maxLines: 8,
                    controller: todo_detail,
                    decoration: InputDecoration(
                        labelText: 'รายละเอียด', 
                        border: OutlineInputBorder())),
            SizedBox(height: 30,),
            // ปุ่่มเพิ่มข้อมูล
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                    onPressed: () {
                      print('----------');
                      print('title: ${todo_title.text}');
                      print('detail: ${todo_detail.text}');
                      postTodo();
                      setState(() {
                        todo_title.clear();
                        todo_detail.clear();
                        });
                    final snackBar = SnackBar(
                    content: const Text('อัพเดตรายการแล้ว'));
                    
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);


                    },
                    child: Text ("เพิ่มรายการ"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 20, 50, 20)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))
                      )
                      ),

            ),
          ],
        ),
      ),
        
    );
  }

  Future postTodo() async {
    // var url = Uri.https('https://4572-2405-9800-bc00-4316-d407-267f-c72c-c459.ngrok.io','/api/post-todolist');
    var url = Uri.http('192.168.1.108:8000','/api/post-todolist');
    // var url = Uri.https('aaaaa.ngrok.io','/api/post-todolist');
    Map<String, String> header = {"Content-type":"application/json"};
    String jsondata = '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);    
    print('----result------');
    print(response.body);
  }

}