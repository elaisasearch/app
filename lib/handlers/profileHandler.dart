import 'dart:convert';

import 'package:app/models/searchResponseModel.dart';
import 'package:app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<User> signIn(BuildContext context, String email, String password) async {
  User user;

  final response = await http.post(
      'https://api.elaisa.org/signin?email=$email&password=$password&key=mY6qXTRUczbx3Fav');

  if (response.statusCode == 200) {
    // parse Elaisa API result to objects
    final apiResponse = SearchAPIResponse.fromJson(json.decode(response.body));

    if (apiResponse.result['message'] == 'success') {
      user = new User(
          firstname: apiResponse.result['user']['firstname'],
          lastname: apiResponse.result['user']['lastname'],
          email: apiResponse.result['user']['email']);
    } else {
      print('failed. status code is ${response.statusCode}');

      user = new User();
    }
  }

  return user;
}
