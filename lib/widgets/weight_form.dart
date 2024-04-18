import 'package:flutter/material.dart';

class WeightForm extends StatefulWidget {
  const WeightForm({super.key});

  @override
  State<WeightForm> createState() => _WeightFormState();
}

class _WeightFormState extends State<WeightForm> {
  final formData = GlobalKey<FormState>();

  double? newWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
          key: formData,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    hintText: "Wprowadz nowy pomiar", label: Text("Waga")),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null ||
                      double.tryParse(value)! <= 0) {
                    return "Wprowadzona waga jest niepoprawna.";
                  }
                  return null;
                },
                onSaved: (value) {
                  newWeight = double.tryParse(value!);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (formData.currentState!.validate()) {
                          formData.currentState!.save();
                          Navigator.of(context).pop(newWeight!);
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
  }
}