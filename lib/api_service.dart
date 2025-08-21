import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'task.dart';


class ApiService {
  final String baseUrl='http://${dotenv.env['BACKEND_API']}:${dotenv.env['PORT']}';

  Future<List<Task>> fetchTasks() async{
    final response=await http.get(Uri.parse('$baseUrl/tasks'));
    if(response.statusCode==200){
      List<dynamic> body=jsonDecode(response.body);
      return body.map((json)=>Task.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> addTask(String text) async{
    final response=await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({'text':text}),
      );
      if(response.statusCode==201){
        return Task.fromJson(jsonDecode(response.body));
      }else{
        throw Exception('Failed to add task');
      }
      
  }

  Future<void> updateTask(Task task) async{
    final response=await http.put(
      Uri.parse('$baseUrl/tasks/${task.id}'),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({'isDone':task.isDone}),
      );
      if(response.statusCode!=200){
        throw Exception('Failed to update task');
      }
      
  }

  Future<void> deleteTask(String id) async{
    final response=await http.delete(
      Uri.parse('$baseUrl/tasks/$id'),
      );
      if(response.statusCode!=200){
        throw Exception('Failed to delete task');
      }
      
  }
  
}
