import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:book_bank/screens/homescreen/cart.dart';
import 'package:book_bank/screens/homescreen/favouritelist.dart';
import 'package:book_bank/screens/homescreen/homescreen2.dart';


class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}


class ProductListing extends StatefulWidget {
  static const String id = 'ProductListing';

  @override
  _ProductListingState createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  List<Product> _products = [
    Product(name: "Product 1", price: 10.0),
    Product(name: "Product 2", price: 20.0),
    Product(name: "Product 3", price: 30.0),
  ];
  Object? _institutionType;
  Object? selectedValue ;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purpleAccent.withOpacity(0.25),
        automaticallyImplyLeading: false, // add this property and set it to false
        leading: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            splashColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0.5),
              child:
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new_outlined,
                  color: Colors.purple,
                  size: 30,),
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
              child: Text(
                "",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Text(
                "",
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purpleAccent,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.purple,
            onPressed: () {
              // Handle notifications button press
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Handle add to cart button press
            },
          ),

        ],
      ),



      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Text(
                'Book Listing',
                style: TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.1),
                      blurRadius: 10.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    'https://d1e4pidl3fu268.cloudfront.net/769ee408-6c94-4c5b-b2ef-786f90e4ead7/BB85249399B7423394A42A8489A5DE20.crop_626x470_0,78.preview.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 40.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Column(children: [
                        Text.rich(TextSpan(
                          text:
                          "Note:                                                                 ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.purple,
                          ),
                        )),
                        Text.rich(TextSpan(
                          text:
                          "Please read and accept the terms and conditions",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ))
                      ]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              SizedBox(height: 25),


              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.pinkAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent,
                      blurRadius: 5,
                      offset: Offset(1, 5),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book State",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 20),
                    Row(
                      children: [
                        Radio(
                          value: "donation",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                        ),
                        Text(
                          "Donation",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Radio(
                          value: "sell",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                        ),
                        Text(
                          "Sell",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Radio(
                          value: "exhange",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                            if (selectedValue = value != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NewScreen()),
                              );
                            };

                          },
                        ),
                        Text(
                          "Exchange",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                      ],
                    ),


                    SizedBox(height: 10),

                  ],
                ),
              ),

              SizedBox(height: 30),


              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book Name/Title",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book name/title",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Book ISBN",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book ISBN",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Book Author Name",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book author name",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Book Publisher",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book publisher",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Book Price",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book price",
                      ),
                    ),
                    SizedBox(height: 10),

                    SizedBox(height: 10),

                  ],
                ),
              ),
              SizedBox(height: 36),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pinkAccent, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Book Catergory",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(
                          child: Text("Historical Fiction",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Historical Fiction",
                        ),
                        DropdownMenuItem(
                          child: Text("Non-fiction",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Non-fiction",
                        ),
                        DropdownMenuItem(
                          child: Text("Fiction",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Fiction",
                        ),
                        DropdownMenuItem(
                          child: Text("Romance novel",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Romance novel",
                        ),
                        DropdownMenuItem(
                          child: Text("Children's literature",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Children's literature",
                        ),
                        DropdownMenuItem(
                          child: Text("Horror",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Horror",
                        ),
                        DropdownMenuItem(
                          child: Text("Biography",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Biography",
                        ),
                        DropdownMenuItem(
                          child: Text("Memoir",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Memoir",
                        ),
                        DropdownMenuItem(
                          child: Text("Science fiction",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Science fiction",
                        ),

                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple[400]!,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 1.5,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Select book catergory",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              SizedBox(height: 16.0),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book Institution",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),

                    SizedBox(height: 20),
                    Row(
                      children: [
                        Radio(
                          value: "school",
                          groupValue: _institutionType,
                          onChanged: (value) {
                            setState(() {
                              _institutionType = value;
                            });
                          },
                        ),
                        Text(
                          "School",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purpleAccent,
                          ),
                        ),
                        Radio(
                          value: "college",
                          groupValue: _institutionType,
                          onChanged: (value) {
                            setState(() {
                              _institutionType = value;
                            });
                          },
                        ),
                        Text(
                          "College",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purpleAccent,
                          ),
                        ),
                        Radio(
                          value: "university",
                          groupValue: _institutionType,
                          onChanged: (value) {
                            setState(() {
                              _institutionType = value;
                            });
                          },
                        ),
                        Text(
                          "University",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purpleAccent,
                          ),
                        ),
                      ],
                    ),


                    SizedBox(height: 20),
                    Text(
                      _institutionType == "school"
                          ? "Book school name"
                          : _institutionType == "college"
                          ? "Book college name"

                          : "Book university name",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter name",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Book class/semester name",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter name",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),






              SizedBox(height: 40),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pinkAccent, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Book Language",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(
                          child: Text("Spanish",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Spanish",
                        ),
                        DropdownMenuItem(
                          child: Text("English",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "English",
                        ),
                        DropdownMenuItem(
                          child: Text("Arabic",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Arabic",
                        ),
                        DropdownMenuItem(
                          child: Text("French",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "French",
                        ),
                        DropdownMenuItem(
                          child: Text("Russian",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Russian",
                        ),
                        DropdownMenuItem(
                          child: Text("Portuguese",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Portuguese",
                        ),
                        DropdownMenuItem(
                          child: Text("Chinese",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Chinese",
                        ),
                        DropdownMenuItem(
                          child: Text("German",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "German",
                        ),
                        DropdownMenuItem(
                          child: Text("Hindi",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Hindi",
                        ),
                        DropdownMenuItem(
                          child: Text("Urdu",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Urdu",
                        ),

                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple[400]!,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 1.5,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Select book language",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],


                ),

              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pinkAccent, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Book Condition",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(
                          child: Text("As New",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "As New",
                        ),
                        DropdownMenuItem(
                          child: Text("Good",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Good",
                        ),
                        DropdownMenuItem(
                          child: Text("Fine",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Fine",
                        ),
                        DropdownMenuItem(
                          child: Text("Fair",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Fair",
                        ),


                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple[400]!,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 1.5,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Select book condition",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],


                ),

              ),

              SizedBox(height: 40),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple,
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book Publication Date",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "YYYY-MM-DD",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Number Of Pages",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter number of pages",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Book Type",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book type ",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "SKU",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book sku",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Book Quantity",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book quantity",
                      ),
                    ),
                    SizedBox(height: 10),



                  ],
                ),
              ),



              SizedBox(height: 20),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.5),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Location",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),),
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.1),
                            blurRadius: 10.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          'https://www.meupositivo.com.br/doseujeito/wp-content/uploads/2018/11/funcoes-google-maps-viagens.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(

                        border: OutlineInputBorder(),
                        hintText: "Robert Robertson, 1234 NW "
                            "Bobcat Lane, St. Robert, MO 65584-5678",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Upload Up to 3 Photos",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),),
                    SizedBox(height: 15),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.1),
                            blurRadius: 10.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      height: 250,
                      child: Center(
                        child: Text("Drop your images here to upload"),
                      ),
                    ),
                    SizedBox(height: 30),



                    ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            backgroundColor: Colors.purple,

                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero)),
                        icon: const Icon(
                          Icons.upload_file_sharp,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Upload',
                          style: TextStyle(color: Colors.white),
                        )),

                    SizedBox(height: 40),






                  ],
                ),
              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),

                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.1),
                              blurRadius: 10.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          maxLines: 15,
                        ),
                      ),
                    ),


                  ],
                ),
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, ProductListing.id);

                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 2),
                          backgroundColor: Colors.purple,

                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                      icon: const Icon(
                        Icons.list_alt_sharp,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'View product listing',
                        style: TextStyle(color: Colors.white),
                      )),


                  ElevatedButton.icon(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          backgroundColor: Colors.purple,

                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                      icon: const Icon(
                        Icons.safety_check_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Compeleted',
                        style: TextStyle(color: Colors.white),
                      )),



                ],
              ),
            ],
          ),
        ),

      ),



      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.purple,
              ),
              onPressed: () {
                Navigator.pushNamed(context, homescreen2.id);

              },
            ),
            IconButton(
              icon: Icon(
                Icons.chat,
                color: Colors.purple,
              ),
              onPressed: () {},
            ),
            SizedBox(width: 32),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.purple,
              ),
              onPressed: () {
                Navigator.pushNamed(context, cart.id);

              },
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.purple,
              ),
              onPressed: () {
                Navigator.pushNamed(context, favouritelist.id);

              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, ProductListing.id);

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,



    );
  }
}

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  Object? _institutionType;
  @override
  Widget build(BuildContext context) {
    String selectedValue = '';
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purpleAccent.withOpacity(0.25),
        automaticallyImplyLeading: false, // add this property and set it to false
        leading: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            splashColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0.5),
              child:
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new_outlined,
                  color: Colors.purple,
                  size: 30,),
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
              child: Text(
                "",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Text(
                "",
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purpleAccent,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.purple,
            onPressed: () {
              // Handle notifications button press
            },
          ),
          IconButton(
            icon: Icon(Icons.verified_user),
            onPressed: () {
              // Handle add to cart button press
            },
          ),

        ],
      ),



      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Text(
                'Exchange Book Listing ',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.redAccent.withOpacity(0.5),
                      offset: Offset(1.0, 2.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withOpacity(0.5),
                      blurRadius: 10.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    'https://us.123rf.com/450wm/spicytruffel/spicytruffel2207/spicytruffel220700200/189380814-book-gift-swap-landing-page-library-exchange-or-bookstore-sale-day-website-ui-education-festival.jpg?ver=6',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Column(children: [
                        Text.rich(TextSpan(
                          text:
                          "Note:                                                                 ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.purple,
                          ),
                        )),
                        Text.rich(TextSpan(
                          text:
                          "Please read and accept the terms and conditions",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ))
                      ]),
                    ],
                  ),
                ),
              ),


              SizedBox(height: 30.0),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 3. Create a Text widget for the "Book State" label
                    Text(
                      "Enter details of Exchange books",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    SizedBox(height: 10),
                    // 4. Create three RadioListTile widgets for each option
                    //    and wrap them in a Column

                  ],
                ),
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book Name/Title",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book name/title",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Book ISBN",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book ISBN",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Book Author Name",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book author name",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Book Publisher",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book publisher",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Book Price",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book price",
                      ),
                    ),
                    SizedBox(height: 10),

                    SizedBox(height: 10),

                  ],
                ),
              ),

              SizedBox(height: 36),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.pinkAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Book Catergory",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(
                          child: Text("Historical Fiction",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Historical Fiction",
                        ),
                        DropdownMenuItem(
                          child: Text("Non-fiction",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Non-fiction",
                        ),
                        DropdownMenuItem(
                          child: Text("Fiction",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Fiction",
                        ),
                        DropdownMenuItem(
                          child: Text("Romance novel",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Romance novel",
                        ),
                        DropdownMenuItem(
                          child: Text("Children's literature",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Children's literature",
                        ),
                        DropdownMenuItem(
                          child: Text("Horror",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Horror",
                        ),
                        DropdownMenuItem(
                          child: Text("Biography",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Biography",
                        ),
                        DropdownMenuItem(
                          child: Text("Memoir",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Memoir",
                        ),
                        DropdownMenuItem(
                          child: Text("Science fiction",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Science fiction",
                        ),

                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple[400]!,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 1.5,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Select book catergory",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              SizedBox(height: 16.0),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book Institution",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),

                    SizedBox(height: 20),
                    Row(
                      children: [
                        Radio(
                          value: "school",
                          groupValue: _institutionType,
                          onChanged: (value) {
                            setState(() {
                              _institutionType = value;
                            });
                          },
                        ),
                        Text(
                          "School",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purpleAccent,
                          ),
                        ),
                        Radio(
                          value: "college",
                          groupValue: _institutionType,
                          onChanged: (value) {
                            setState(() {
                              _institutionType = value;
                            });
                          },
                        ),
                        Text(
                          "College",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purpleAccent,
                          ),
                        ),
                        Radio(
                          value: "university",
                          groupValue: _institutionType,
                          onChanged: (value) {
                            setState(() {
                              _institutionType = value;
                            });
                          },
                        ),
                        Text(
                          "University",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.purpleAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      _institutionType == "school"
                          ? "Book school name"
                          : _institutionType == "college"
                          ? "Book college name"

                          : "Book university name",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter name",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Book class/semester name",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter name",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),






              SizedBox(height: 40),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.pinkAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Book Language",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(
                          child: Text("Spanish",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Spanish",
                        ),
                        DropdownMenuItem(
                          child: Text("English",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "English",
                        ),
                        DropdownMenuItem(
                          child: Text("Arabic",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Arabic",
                        ),
                        DropdownMenuItem(
                          child: Text("French",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "French",
                        ),
                        DropdownMenuItem(
                          child: Text("Russian",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Russian",
                        ),
                        DropdownMenuItem(
                          child: Text("Portuguese",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Portuguese",
                        ),
                        DropdownMenuItem(
                          child: Text("Chinese",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Chinese",
                        ),
                        DropdownMenuItem(
                          child: Text("German",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "German",
                        ),
                        DropdownMenuItem(
                          child: Text("Hindi",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Hindi",
                        ),
                        DropdownMenuItem(
                          child: Text("Urdu",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Urdu",
                        ),

                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple[400]!,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 1.5,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Select book language",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],


                ),

              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.pinkAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Book Condition",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(
                          child: Text("As New",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "As New",
                        ),
                        DropdownMenuItem(
                          child: Text("Good",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Good",
                        ),
                        DropdownMenuItem(
                          child: Text("Fine",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Fine",
                        ),
                        DropdownMenuItem(
                          child: Text("Fair",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                          value: "Fair",
                        ),


                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple[400]!,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purple,
                            width: 1.5,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Select book condition",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],


                ),

              ),

              SizedBox(height: 40),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple,
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book Publication Date",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "YYYY-MM-DD",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Number Of Pages",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter number of pages",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Book Type",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book type ",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "SKU",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book sku",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Book Quantity",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter book quantity",
                      ),
                    ),
                    SizedBox(height: 10),



                  ],
                ),
              ),



              SizedBox(height: 20),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.5),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Location",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),),
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.1),
                            blurRadius: 10.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          'https://www.meupositivo.com.br/doseujeito/wp-content/uploads/2018/11/funcoes-google-maps-viagens.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(

                        border: OutlineInputBorder(),
                        hintText: "Robert Robertson, 1234 NW "
                            "Bobcat Lane, St. Robert, MO 65584-5678",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Upload Up to 3 Photos",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),),
                    SizedBox(height: 15),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.1),
                            blurRadius: 10.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      height: 250,
                      child: Center(
                        child: Text("Drop your images here to upload"),
                      ),
                    ),
                    SizedBox(height: 30),



                    ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            backgroundColor: Colors.purple,

                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero)),
                        icon: const Icon(
                          Icons.upload_file_sharp,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Upload',
                          style: TextStyle(color: Colors.white),
                        )),

                    SizedBox(height: 40),






                  ],
                ),
              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),

                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.1),
                              blurRadius: 10.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          maxLines: 15,
                        ),
                      ),
                    ),


                  ],
                ),
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, ProductListing.id);

                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 2),
                          backgroundColor: Colors.purple,

                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                      icon: const Icon(
                        Icons.list_alt_sharp,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'View product listing',
                        style: TextStyle(color: Colors.white),
                      )),


                  ElevatedButton.icon(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          backgroundColor: Colors.purple,

                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                      icon: const Icon(
                        Icons.safety_check_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Compeleted',
                        style: TextStyle(color: Colors.white),
                      )),



                ],
              ),
            ],
          ),
        ),

      ),



      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.purple,
              ),
              onPressed: () {
                Navigator.pushNamed(context, homescreen2.id);

              },
            ),
            IconButton(
              icon: Icon(
                Icons.chat,
                color: Colors.purple,
              ),
              onPressed: () {},
            ),
            SizedBox(width: 32),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.purple,
              ),
              onPressed: () {
                Navigator.pushNamed(context, cart.id);

              },
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.purple,
              ),
              onPressed: () {
                Navigator.pushNamed(context, favouritelist.id);

              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, ProductListing.id);

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,



    );
  }
}