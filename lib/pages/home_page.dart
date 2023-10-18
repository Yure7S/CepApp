import 'package:cep_app/models/address_model.dart';
import 'package:cep_app/repositories/cep_repository.dart';
import 'package:cep_app/repositories/cep_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePageState extends State<HomePage> {
  final CepRepository cepRepository = CepRepositoryImpl();
  AddressModel? addressModel;
  var loading = false;

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
                              setState(() => loading = true);
                              setState(() => addressModel = null);
                              AddressModel am = await cepRepository.getCep(cepEC.text);
                              setState(() => addressModel = am);
                              setState(() => loading = false);
                            }
                          } catch (e) {
                            setState(() => loading = false);
                            setState(() => addressModel = null);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("The zip code entered is not valid")));
                          }
                        },
                        child: const Text("Search")),
                    const SizedBox(height: 25),
                    Visibility(
                      visible: loading,
                      child: const CircularProgressIndicator(),
                    ),
                    Visibility(
                      visible: addressModel != null,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: const Border(left: BorderSide(
                              color: Colors.deepPurple,
                              width: 5,
                            ),
                          ),
                          // borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: const Offset(0, 3)
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            children: [
                              Text(
                                "${addressModel?.logradouro}, ${addressModel?.bairro}, ${addressModel?.localidade} - ${addressModel?.uf}",
                                style: const TextStyle(
                                  fontSize: 17
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
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
