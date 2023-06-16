

// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Books {

  String? book_image;
  String? book_Name;
  String? price;
  String? status;
  String? book_author;

  Books(
      {this.book_image,
        this.book_Name,
        this.price,
        this.status,
        this.book_author});

  factory Books.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Books(
      book_image:data ['Book_image'],
      book_Name: data['Book_name'],
      book_author:data['Book_author'] ,
      price:data ['Price'],
      status: data['Status'],

    );
  }
}