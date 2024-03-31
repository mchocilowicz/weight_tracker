import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Weight Tracker',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<WeightData> weightList = [];

  @override
  Widget build(BuildContext context) {
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
          showModalBottomSheet<WeightData>(
              isDismissible: false,
              context: context,
              builder: (context) {
                return const WeightForm();
              }).then((value) => {
                if (value != null)
                  {
                    setState(() {
                      weightList.insert(0, value);
                    })
                  }
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
            final weight = weightList[index];
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(DateFormat("MM.dd.yyyy").format(weight.createdAt)),
                  Text('${weight.amount}'),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
              ),
          itemCount: weightList.length),
    );
  }
}

class WeightForm extends StatefulWidget {
  const WeightForm({super.key});

  @override
  State<WeightForm> createState() => _WeightFormState();
}

class WeightData {
  final double amount;
  final DateTime createdAt;

  WeightData({required this.amount, required this.createdAt});
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
                          Navigator.of(context).pop(WeightData(
                              amount: newWeight!, createdAt: DateTime.now()));
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
