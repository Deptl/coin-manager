import 'package:coin_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncomeCategoryScreen extends StatefulWidget {
  const IncomeCategoryScreen({super.key});

  @override
  State<IncomeCategoryScreen> createState() => _IncomeCategoryScreenState();
}

class _IncomeCategoryScreenState extends State<IncomeCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Income Category",
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
                    title: Center(child: Text("Add Income Category")),
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
                                  final amountSnackbar = SnackBar(
                                      content: Text("Please Enter Amount",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: secondary)));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(amountSnackbar);
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
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: ListTile(
                leading: Text("Salary",
                    style: TextStyle(
                        fontFamily: "Poppins", color: primary, fontSize: 15)),
                trailing: IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.trashCan,
                      color: Colors.red,
                    )),
              ),
            );
          }),
    );
  }
}
