

// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Nearme{

  String? book_image;
  String? book_Name;
  String? price;
  String? status;
  String? book_author;

  Nearme(
      {this.book_image,
        this.book_Name,
        this.price,
        this.status,
        this.book_author});

  factory Nearme.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Nearme(
      book_image:data ['image'],
      book_Name: data['name'],
      book_author:data['author'] ,
      price:data ['Price'],
      status: data['Status'],

    );
  }
}