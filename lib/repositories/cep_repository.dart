import 'package:cep_app/models/address_model.dart';

abstract interface class CepRepository {
  Future<AddressModel> getCep(String cep);
}
