import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Medicines extends StatefulWidget {
  const Medicines({Key? key}) : super(key: key);

  @override
  State<Medicines> createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  bool isLoading=false;
  List name=[];
  Future getData() async {
    var url = 'https://dbmsapi.herokuapp.com/api/medicine/getMedicines';
    var response = await http.get(Uri.parse(url));

    Map Data = json.decode(response.body);
    name = Data["medicines"];
  }

   @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    getData().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicines"),
        backgroundColor: Colors.amber,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: name.length,
              itemBuilder: (BuildContext context, int index) => Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 55,
                                      height: 55,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.amber,
                                        backgroundImage: NetworkImage(
                                          name[index]
                                              ["imageUrl"],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            name[index]
                                                ["name"],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 8),
                                        Text(
                                            name[index]
                                                ["expiryDate"],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.23),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text("Quantity :",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                name[index]
                                                    ["quantity"],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                                        Row(
                                          children: [
                                            const Text("MRP :",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                name[index]
                                                    ["mrp"],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),
                  )),
    );
  }
}
