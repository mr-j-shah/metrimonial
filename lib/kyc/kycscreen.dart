import 'package:flutter/material.dart';
import 'package:onfido_sdk/onfido_sdk.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class KYCScreen extends StatelessWidget {
  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  String _applicantId;
  String _sdktoken;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KYC Verification'),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 240,
                  height: 60,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    onChanged: (ValueKey) {},
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid email address';
                      } else {
                        return null;
                      }
                    }),
                    controller: firstname,
                    // obscureText: true,
                    cursorColor: const Color.fromRGBO(36, 59, 85, 1),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(238, 238, 238, 1),
                      // border: OutlineInputBorder(),
                      // labelText: 'Email',
                      hintText: 'First Name',
                      hintStyle:
                          const TextStyle(color: Color.fromRGBO(36, 59, 85, 1)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: const Color.fromRGBO(238, 238, 238, 1)),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: const Color.fromRGBO(238, 238, 238, 1)),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 240,
                  height: 60,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    // obscureText: true,
                    onChanged: (ValueKey) {},
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Last Name';
                      } else {
                        return null;
                      }
                    }),
                    controller: lastname,
                    // obscureText: true,
                    cursorColor: const Color.fromRGBO(36, 59, 85, 1),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(238, 238, 238, 1),
                      hintText: 'Last Name',
                      hintStyle:
                          const TextStyle(color: Color.fromRGBO(36, 59, 85, 1)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: const Color.fromRGBO(238, 238, 238, 1)),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: const Color.fromRGBO(238, 238, 238, 1)),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                child: InkWell(
                  onTap: (() async {
                    _applicantId =
                        await applicants(firstname.text, lastname.text);
                    _sdktoken = await getsdk(_applicantId);
                    startOnfido(_sdktoken);
                  }),
                  child: Container(
                    alignment: Alignment.center,
                    width: 240,
                    height: 60,
                    decoration: BoxDecoration(
                        // ignore: prefer_const_constructors
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color.fromRGBO(20, 30, 48, 1),
                            const Color.fromRGBO(36, 59, 85, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Adagio Sans",
                          color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  startOnfido(String sdktoken) async {
    try {
      final Onfido onfido = Onfido(sdkToken: sdktoken);
      final response = await onfido.start(
        flowSteps: FlowSteps(
          proofOfAddress: true,
          welcome: true,
          documentCapture: DocumentCapture(
              documentType: DocumentType.generic, countryCode: CountryCode.IND),
          faceCapture: FaceCaptureType.photo,
        ),
      );

      print("startOnfido response :: $response");

      onfido.startWorkflow("f65f6747-2961-43c7-a742-23e77b13f9a3");
    } catch (error) {
      print("startOnfido error :: $error");
    }
  }

  Future<String> applicants(String firstname, String lastname) async {
    print(firstname);
    print(lastname);
    final response = await http.post(
      Uri.parse('https://api.onfido.com/v3/applicants'),
      headers: {
        "Authorization":
            "Token token=api_live.ZtCnzKJbgwZ.Y58gfvGV0k-nL2fsc7VBXKLCYhG9P8t2",
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        <String, dynamic>{"first_name": firstname, "last_name": lastname},
      ),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      Map<String, dynamic> resposnsemap = jsonDecode(response.body);
      print(resposnsemap["id"]);
      return resposnsemap["id"];
    } else {
      return null;
    }
  }

  Future<String> getsdk(String applicant_id) async {
    print(firstname);
    print(lastname);
    final response = await http.post(
      Uri.parse('https://api.onfido.com/v3/sdk_token'),
      headers: {
        "Authorization":
            "Token token=api_live.ZtCnzKJbgwZ.Y58gfvGV0k-nL2fsc7VBXKLCYhG9P8t2",
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        <String, dynamic>{
          "applicant_id": applicant_id,
          "application_id": "com.metromenial.app"
        },
      ),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> resposnsemap = jsonDecode(response.body);
      print(resposnsemap["token"]);
      return resposnsemap["token"];
    } else {
      return null;
    }
  }
}
