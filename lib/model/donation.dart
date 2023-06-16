

// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {

  String? donationbook_image;
  String? nGO;
  String? donationbook_Name;
  String? num_of_books;
  String? status;
  String? catagory;

  Donation(
      {this.donationbook_image,
        this.nGO,
        this.num_of_books,
        this.status,
        this.catagory});

  factory Donation.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Donation(
      donationbook_image:data ['Image'],
      nGO: data['NGO'],
      catagory:data['Catagory'] ,
      num_of_books:data ['Num_of_books'],
      status: data['Status'],

    );
  }
}