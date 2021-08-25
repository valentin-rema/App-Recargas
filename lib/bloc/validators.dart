import 'dart:async';
//import 'package:flutter/material.dart';



class Validators{


  final validarEmail= StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';   
      RegExp regExp = RegExp(pattern);
      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError('Email no valido');
      }
    } 
  );

  final validarPassword= StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){

      if(password.length>5){
        sink.add(password);
      }else{
        sink.addError('la contraseña es de al menos 6 caracteres');
      }
    }
  );

}