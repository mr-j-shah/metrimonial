import 'package:flutter/material.dart';
import 'package:onfido_sdk/onfido_sdk.dart';

class KYCScreen extends StatelessWidget {
  final Onfido onfido = Onfido(
    sdkToken: 'eyJhbGciOiJFUzUxMiJ9.eyJleHAiOjE2ODQ0NDM3NzksInBheWxvYWQiOnsiYXBwIjoiMzA2NzdkNDctZWM5MS00MWVkLTg3OTAtM2YyOWM0N2E5MmFlIiwiYXBwbGljYXRpb25faWQiOiJjb20ubWV0cm9tZW5pYWwuYXBwIiwiY2xpZW50X3V1aWQiOiIyZGJhMmFlMy0wNmYzLTRkMjMtOGI3Zi1iMWU2YjAzY2JkZWUiLCJpc19zYW5kYm94Ijp0cnVlLCJpc19zZWxmX3NlcnZpY2VfdHJpYWwiOnRydWUsImlzX3RyaWFsIjp0cnVlLCJzYXJkaW5lX3Nlc3Npb24iOiJhYmI2OWYxNC01OWVhLTQ1NTktYmRmOC04MjYzNDRmMmIzNTAifSwidXVpZCI6InBsYXRmb3JtX3N0YXRpY19hcGlfdG9rZW5fdXVpZCIsInVybHMiOnsiZGV0ZWN0X2RvY3VtZW50X3VybCI6Imh0dHBzOi8vc2RrLm9uZmlkby5jb20iLCJzeW5jX3VybCI6Imh0dHBzOi8vc3luYy5vbmZpZG8uY29tIiwiaG9zdGVkX3Nka191cmwiOiJodHRwczovL2lkLm9uZmlkby5jb20iLCJhdXRoX3VybCI6Imh0dHBzOi8vYXBpLm9uZmlkby5jb20iLCJvbmZpZG9fYXBpX3VybCI6Imh0dHBzOi8vYXBpLm9uZmlkby5jb20iLCJ0ZWxlcGhvbnlfdXJsIjoiaHR0cHM6Ly9hcGkub25maWRvLmNvbSJ9fQ.MIGHAkEHwlzo-RD0zO2dbl1OuMGNkZ_AQ9E1KjueTMD66MBYN7KE_J7leTIBqh7HLYftVLNdzvEB-S2l9pFDQqdQIhXBbQJCAQX23vQzByuH4s-cIf_FGkq8d_RImrfKucPX7nLSL7nfd6S2DjL06nnu3rwxaRV3-od_XJzgyeIEHg9KJBe2oc3f',
    //
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KYC Verification'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            startOnfido();
          },
          child: Text('Start Verification'),
        ),
      ),
    );
  }

  startOnfido() async {
    try {
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
    } catch (error) {
      print("startOnfido error :: $error");
    }
  }
}
