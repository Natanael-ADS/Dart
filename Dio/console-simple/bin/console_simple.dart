import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mysql1/mysql1.dart';
import 'cliente_bean.dart';

void main() async {
  Iterable<ClienteBean> clientes;

  print("${DateTime.now()} - Iniciado o processo de consultar na web...");
  clientes = await _web();

  print("${DateTime.now()} - Escrevendo no arquivo sql.text");
  _writeFile(clientes);

  print("${DateTime.now()} - Inserindo no database dart na tabela cliente...");
  await _insertMySql(clientes);

  print("${DateTime.now()} - Processo finalizado.");
}

_writeFile(Iterable<ClienteBean> clientes) async {
  final pathFile = "C:\\Projetos\\Dart\\Dio\\console-simple\\bin\\sql.txt";
  final file = File(pathFile);
  String mensagem = "";
  for (ClienteBean bean in clientes) {
    mensagem += "\n${bean.toJson()}";
  }

  mensagem = "Total de registro: ${clientes.length} \n" + mensagem;
  file.writeAsStringSync(mensagem);
}

_insertMySql(Iterable<ClienteBean> clientes) async {
  final settings = ConnectionSettings(
    host: "127.0.0.1",
    db: "dart",
    password: "quantum28042004",
    port: 3370,
    user: "quantum",
  );

  final connection = await MySqlConnection.connect(settings);

  const SCRIPT = "INSERT cliente(codigo, cpfCgc, nome) VALUES(?,?,?)";
  for (var cliente in clientes) {
    var params = [
      cliente.codigo,
      cliente.cpfCgc,
      cliente.nomeRazaoSocial,
    ];
    await connection.query(SCRIPT, params);
  }

  await connection.close();
}

Future<Iterable<ClienteBean>> _web() async {
  final dio = Dio();
  const BASE_URL = "http://localhost:8079/QuantumWebServiceGeralREST";
  const PATH_URL = "/webresources/clientes/";
  const CRIPT = "F26BD9453C22190C70E9543C29150679E159C5BF/";

  int total = 0;

  String basePathTotal = BASE_URL + PATH_URL + "buscarTotalUpdates/" + CRIPT;
  var response = await dio.get(basePathTotal);
  total = response.data;

  var basePathCript = BASE_URL + PATH_URL + CRIPT;
  var offset = 0;
  var limit = 100;

  List<ClienteBean> clienteBeans = [];
  String url;
  while (offset < total) {
    url = basePathCript + offset.toString() + "/" + limit.toString() + "/";
    var response = await dio.get(url);
    final clientes = (response.data as List)
        .map(
          (e) => ClienteBean.fromMap(e),
        )
        .toList();
    clienteBeans.addAll(clientes);
    offset += limit;
  }
  return clienteBeans;
}
