import 'package:book_bank/model/product_model.dart';
import 'package:flutter/material.dart';

class FormProduct extends StatelessWidget {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();
  final TextEditingController _controllerValue = TextEditingController();
  FormProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastro de Produtos",
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              focusNode: FocusNode(),
              controller: _controllerName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Product Name:",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllerQuantity,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Quantity:",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllerValue,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Value:",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal[700],
                onSurface: Colors.amber,
                elevation: 20,
              ),
              onPressed: () {
                final String name = _controllerName.text;
                final int? quantity = int.tryParse(_controllerQuantity.text);
                final double? value = double.tryParse(_controllerValue.text);

                final Product newProduct = Product(name, quantity, value);
                debugPrint(newProduct.toString());
              },
              child: const Text(
                "Cadastrar",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}