import 'dart:convert';

class ClienteBean {
  int codigo;
  String cpfCgc;
  String nomeRazaoSocial;

  ClienteBean({
    required this.codigo,
    required this.cpfCgc,
    required this.nomeRazaoSocial,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'cpfCgc': cpfCgc,
      'nomeRazaoSocial': nomeRazaoSocial,
    };
  }

  factory ClienteBean.fromMap(Map<String, dynamic> map) {
    return ClienteBean(
      codigo: map['codigo'],
      cpfCgc: map['cpfCgc'],
      nomeRazaoSocial: map['nomeRazaoSocial'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClienteBean.fromJson(String source) =>
      ClienteBean.fromMap(json.decode(source));
}
