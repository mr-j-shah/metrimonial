import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class statuscheck extends StatefulWidget {
  const statuscheck({Key key}) : super(key: key);

  @override
  State<statuscheck> createState() => _statuscheckState();
}

class _statuscheckState extends State<statuscheck> {
  @override
  void initState() {
    getvalue();
    super.initState();
  }

  getvalue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String applicant = prefs.getString('applicantid');
    check(applicant);
  }

  Future<String> check(String applicant_id) async {
    final response = await http.post(
      Uri.parse('https://api.eu.onfido.com/v3.6/checks'),
      headers: {
        "Authorization":
            "Token token=api_live.ZtCnzKJbgwZ.Y58gfvGV0k-nL2fsc7VBXKLCYhG9P8t2",
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        <String, dynamic>{
          "applicant_id": "6ce39d59-5ee5-4bbd-8038-9d3b964ceaa7",
          "report_names": ["document", "facial_similarity_photo"]
        },
      ),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      Map<String, dynamic> resposnsemap = jsonDecode(response.body);
      print(resposnsemap["status"]);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Status"),
                content: Text("Status : ${resposnsemap["status"]}"),
              ));
      return resposnsemap["status"];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("KYC Status"),
      ),
    );
  }
}
