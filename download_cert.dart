import 'dart:io';

void main() async {
  final host = 'api.themoviedb.org';
  final port = 443;

  print('Connecting to \$host:\$port...');
  final socket = await SecureSocket.connect(host, port);
  print('Connected.');

  final cert = socket.peerCertificate;
  if (cert != null) {
    final pem = cert.pem;
    final dir = Directory('assets/certificates');
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    
    final file = File('assets/certificates/certificate.pem');
    await file.writeAsString(pem);
    print('Certificate successfully saved to \${file.path}');
  } else {
    print('Failed to retrieve certificate.');
  }
  
  socket.destroy();
}
