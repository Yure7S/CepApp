import 'package:cep_app/models/address_model.dart';
import 'package:dio/dio.dart';

import './cep_repository.dart';

class CepRepositoryImpl implements CepRepository {
  @override
  Future<AddressModel> getCep(String cep) async {
    final response = await Dio().get("https://viacep.com.br/ws/$cep/json/");
    return AddressModel.fromMap(response.data);
  }
}
