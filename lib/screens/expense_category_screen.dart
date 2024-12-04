import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_manager/utils/colors.dart';
import 'package:coin_manager/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenseCategoryScreen extends StatefulWidget {
  const ExpenseCategoryScreen({super.key});

  @override
  State<ExpenseCategoryScreen> createState() => _ExpenseCategoryScreenState();
}

class _ExpenseCategoryScreenState extends State<ExpenseCategoryScreen> {
  final CollectionReference _expenseCollectionReference =
      FirebaseFirestore.instance.collection('Category');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Category",
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: background)),
        backgroundColor: primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                    title: Center(child: Text("Add Expense Category")),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                            child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Name",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: secondary,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primary,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                  fontFamily: "Poppins", color: secondary),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  Toast.showToast("Plaese enter name");
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primary),
                                child: Text("Add",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: background)))
                          ],
                        )),
                      )
                    ],
                  ));
        },
        child: Icon(
          FontAwesomeIcons.plus,
          color: background,
        ),
        backgroundColor: primary,
      ),
      backgroundColor: background,
      body: StreamBuilder<QuerySnapshot>(
        stream: _expenseCollectionReference
            .where('type', isEqualTo: 'expense')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No expense category available'));
          }
          final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final data = documents[index].data() as Map<String, dynamic>;
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Text(data["name"] ?? "",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            color: primary,
                            fontSize: 15)),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.trashCan,
                          color: Colors.red,
                        )),
                  ),
                );
              });
        },
      ),
    );
  }
}
