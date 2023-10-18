import 'dart:convert';

class AddressModel {
  final String cep;
  final String logradouro;
  final String bairro;
  final String localidade;
  final String uf;
  final String ddd;

  AddressModel({
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ddd
  });

  Map<String, dynamic> toMap(){
    return ({
      'cep': cep,
      'logradouro': logradouro,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
      'ddd': ddd
    });
  }

  factory AddressModel.fromMap(Map<String, dynamic> map){
    return AddressModel(
      cep: map["cep"],
      logradouro: map["logradouro"],
      bairro: map["bairro"],
      localidade: map["localidade"],
      uf: map["uf"],
      ddd: map["ddd"]
    );
  }

  factory AddressModel.fromJson(String json) => AddressModel.fromMap(jsonDecode(json));
}