import 'package:dart_mysql/dart_mysql.dart';

void main(List<String> arguments) {
  _main();
}

Future _main() async {
  var settings = ConnectionSettings(
    host: 'localhost',
    db: 'lmark',
    port: 3370,
    user: 'quantum',
    password: 'quantum28042004',
  );
  final connection = await MySqlConnection.connect(settings);

  var script = 'SELECT * FROM config_mobile WHERE imei = ?';
  var result = await connection.query(
    script,
    ['354881100750244'],
  );

  result.first;
  for (var row in result.toList()) {
    print(row.values);
  }
}
