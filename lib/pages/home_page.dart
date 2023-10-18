import 'package:cep_app/models/address_model.dart';
import 'package:cep_app/repositories/cep_repository.dart';
import 'package:cep_app/repositories/cep_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePageState extends State<HomePage> {
  final CepRepository cepRepository = CepRepositoryImpl();
  AddressModel? addressModel;

  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cepEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Search by zip code",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: "Enter the zip code"),
                      controller: cepEC,
                      validator: (value) {
                        String? response = value == null || value.isEmpty ? "ZIP code required" : null;
                        return response;
                      },
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            final valid = formKey.currentState?.validate() ?? false;
                            if (valid) {
                              AddressModel am = await cepRepository.getCep(cepEC.text);
                              setState(() => addressModel = am);
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("The zip code entered is not valid"))
                            );
                          }
                        },
                        child: const Text("Search")),
                    const SizedBox(height: 25),
                    Visibility(
                      visible: addressModel != null,
                      child: Text("${addressModel?.logradouro}, ${addressModel?.bairro}, ${addressModel?.localidade} - ${addressModel?.uf}"),
                    )
                  ],
                ))),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}
