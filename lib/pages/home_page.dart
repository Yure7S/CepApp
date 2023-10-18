import 'package:cep_app/models/address_model.dart';
import 'package:cep_app/repositories/cep_repository.dart';
import 'package:cep_app/repositories/cep_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePageState extends State<HomePage> {
  final CepRepository cepRepository = CepRepositoryImpl();
  AddressModel? addressModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            child: Column(
              children: [
                TextFormField(),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: (){}, child: const Text("Buscar"))
              ],
            )
          )
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}
