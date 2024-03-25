import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Weight Tracker',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final formData = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<int> weightList = random
        .amount((i) => random.decimal(min: 40, scale: 80).ceil(), 16, min: 10);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Tracker'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        tooltip: 'Wprowadz nowy pomiar',
        onPressed: () {
          showModalBottomSheet(
              isDismissible: false,
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                      key: formData,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                                hintText: "Wprowadz nowy pomiar",
                                label: Text("Waga")),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) == null ||
                                  double.tryParse(value)! <= 0) {
                                return "Wprowadzona waga jest niepoprawna.";
                              }
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (formData.currentState!.validate()) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: const Text("Zapisz")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Zamknij"))
                            ],
                          )
                        ],
                      )),
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('${weightList[index]}'),
            );
          },
          separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
              ),
          itemCount: weightList.length),
    );
  }
}
