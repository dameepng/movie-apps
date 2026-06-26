import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpSSLPinning {
  
  static http.Client? _clientInstance;
  
  static http.Client get client => _clientInstance ?? http.Client();
  static Future<void> init() async {
    _clientInstance = await Shared.createLEClient();
  }
}

class Shared {
  static Future<http.Client> createLEClient() async {
    SecurityContext context = SecurityContext(withTrustedRoots: false);
    try {
      List<int> bytes = [];
      bytes = (await rootBundle.load('assets/certificates/certificate.pem'))
          .buffer
          .asUint8List();
      context.setTrustedCertificatesBytes(bytes);
      print('createLEClient: cert loaded');
    } on PlatformException catch (e) {
      print('createLEClient: ${e.message}');
    }
    HttpClient httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    return IOClient(httpClient);
  }
}
