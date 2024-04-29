import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/db/model/weight.dart';
import 'package:weight_tracker/db/repository/weight_repository.dart';
import 'package:weight_tracker/widgets/weight_form.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final List<Weight> weightList = [];
  final WeightRepository repository = WeightRepository();

  @override
  void initState() {
    super.initState();
    repository.getAll().then((value) => setState(() {
      weightList.addAll(value);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () {
        FirebaseAuth.instance.signOut();
      },)],
        title: const Text('Weight Tracker'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        tooltip: 'Wprowadz nowy pomiar',
        onPressed: () {
          showModalBottomSheet<double>(
              isDismissible: false,
              context: context,
              builder: (context) {
                return const WeightForm();
              }).then((value) => {
            if (value != null)
              {
                repository.create(value).then((weight) => {
                  setState(() {
                    weightList.insert(0, weight);
                  })
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
      body: weightList.isEmpty
          ? const Center(
        child: Text('Wprowadz aktualną wagę.'),
      )
          : ListView.separated(
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