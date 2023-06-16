import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:book_bank/screens/homescreen/cart.dart';
import 'package:book_bank/screens/homescreen/ProductListing.dart';
import 'package:book_bank/screens/homescreen/DonationScreenSteps.dart';
import 'package:book_bank/screens/homescreen/favouritelist.dart';
import 'package:flutter/material.dart';
import 'package:book_bank/model/donation.dart';
import '../../model/books.dart';
import '../../model/nearme.dart';
import 'ProductPage2.dart';
import 'WishlistScreen.dart';


class homescreen2 extends StatefulWidget {
  static const String id = 'home_screen_2';

  @override
  State<homescreen2> createState() => _homescreen2State();
}

class _homescreen2State extends State<homescreen2> {
  List<Books> books = [];
  List<Donation> donations = [];
  List<Nearme> nearme = [];

  void _fetchBooks() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('Books').get();
    List<Books> booksList = [];
    for (final document in querySnapshot.docs) {
      final book = Books.fromSnapshot(document);
      booksList.add(book);
    }
    setState(() {
      books = booksList;
    });
  }
  void _fetchNearme() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('Nearme').get();
    List<Nearme> nearmeList = [];
    for (final document in querySnapshot.docs) {
      final near = Nearme.fromSnapshot(document);
      nearmeList.add(near);
    }
    setState(() {
      nearme = nearmeList;
    });
  }

  void _fetchDonations() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('Donation ').get();
    List<Donation> donationList = [];
    for (final document in querySnapshot.docs) {
      final donation = Donation.fromSnapshot(document);
      donationList.add(donation);
    }
    setState(() {
      donations = donationList;
    });
  }

  @override
  void initState() {
    _fetchBooks();
    _fetchDonations();
    _fetchNearme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

// Widget build() and other code...
}
Widget singleproducts(
    BuildContext context,
    String? book_image,
    String? book_Name,
    String? price,
    String? status,
    String? book_auther,
    ) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    height: 420,
    width: 160,
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Image.network("$book_image"),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "$book_Name",
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$price RS',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
                Text(
                  '$status',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
                Text(
                  '$book_auther',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 25),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Cart",
                      style: TextStyle(
                        color: Colors.deepPurple,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, cart.id);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 25),
                      backgroundColor: Colors.purple,
                    ),
                    child: const Text(
                      "Details",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, ProductPage2.id);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
  }


Widget singleproductsfornearme(
    BuildContext context,
    String? book_image,
    String? book_Name,
    String? price,
    String? status,
    String? book_auther,
    ) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    height: 420,
    width: 160,
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Image.network("$book_image"),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "$book_Name",
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$price RS',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
                Text(
                  '$status',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
                Text(
                  '$book_auther',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 25),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Cart",
                      style: TextStyle(
                        color: Colors.deepPurple,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, cart.id);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 25),
                      backgroundColor: Colors.purple,
                    ),
                    child: const Text(
                      "Details",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, ProductPage2.id);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}

Widget newdonatinsngos(BuildContext context, String? image, String? nGO, String? num_of_books, String? status, String? category) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    height: 420,
    width: 160,
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Image.network(image ?? ''),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  nGO ?? '',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  num_of_books ?? '',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
                Text(
                  status ?? '',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
                Text(
                  category ?? '',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 25),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Cart",
                      style: TextStyle(
                        color: Colors.deepPurple,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, cart.id);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 25),
                      backgroundColor: Colors.purple,
                    ),
                    child: const Text(
                      "Details",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, DonationScreenSteps.id);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [

          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications button press
            },
          ),
          IconButton(
            icon: Icon(Icons.account_box),
            onPressed: () {
              // Handle add to cart button press
            },
          ),
        ],
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                ),
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40.0,
                      child: Text(
                        'MG',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Muhammad Ghilman Khan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'khanghilman96@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.purple),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.purpleAccent,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.purple),
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.purpleAccent,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.purple),
              title: Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.purpleAccent,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.purple),
              title: Text(
                'Donation history',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.purpleAccent,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.join_full, color: Colors.purple),
              title: Text(
                'Projects joined',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.purpleAccent,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.payment, color: Colors.purple),
              title: Text(
                'Payment settings',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.purpleAccent,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.payment, color: Colors.purple),
              title: Text(
                'My Books',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.purpleAccent,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.subscriptions, color: Colors.purple),
              title: Text(
                'WishList',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.purpleAccent,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, WishlistScreen.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt_sharp, color: Colors.purple),
              title: Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.purpleAccent,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.purple,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Icon(Icons.thermostat, color: Colors.purple),
                          SizedBox(width: 10.0),
                          Text(
                            "22°C",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.purpleAccent,

                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.purple),
                          SizedBox(width: 10.0),
                          Text(
                            "New York, NY",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple,
                        blurRadius: 5.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: ' Enter Keyword, Title, Author and ISBN',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search_sharp,
                          color: Colors.deepPurpleAccent,
                        ),
                        onPressed: () {

                          // Handle filter button press
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.deepPurpleAccent,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PriceFilter()),
                          );
                          // Handle filter button press
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(height: 16.0),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple,
                            blurRadius: 5.0,
                            offset: Offset(0, 4),

                          ),
                        ],
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://cdn.booktrust.org.uk/globalassets/images/news-and-features/blogs-2022/12.-december/best-books-of-2022-16x9.jpg?w=1920&h=1080&quality=70&anchor=middlecenter')),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: const Color(0xffcc33ff),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 130, bottom: 10),
                                    child: Container(
                                      height: 55,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(50),
                                            bottomLeft: Radius.circular(50),
                                          )),
                                      child: Center(
                                        child: Text(
                                          'New',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                              shadows: [
                                                BoxShadow(
                                                    color: Colors.cyan,
                                                    blurRadius: 10,
                                                    offset: Offset(3, 3))
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    child: Text('Explore now'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.purple),
                                    onPressed: () {},
                                  ),
                                  Text(
                                    'Find Your best books Today!',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                      offset: Offset(0, 4),

                    ),
                  ],
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.science,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.gavel,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.calculate,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.computer,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                    // Add more category icons here
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended',
                      style: TextStyle(color: Colors.purple),
                    ),
                    Text(
                      'View all',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  width: 30,
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: books.length,
                    itemBuilder: (BuildContext context, int index) {
                      return singleproducts(
                        context,
                        books[index].book_image,
                        books[index].book_Name,
                        books[index].price,
                        books[index].status,
                        books[index].book_author,
                      );
                    },
                  ),
                )
              ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Near me',
                      style: TextStyle(color: Colors.purple),
                    ),
                    Text(
                      'View all',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),


              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  width: 30,
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: nearme.length,
                    itemBuilder: (BuildContext context, int index) {
                      return singleproducts(
                        context,
                        nearme[index].book_image,
                        nearme[index].book_Name,
                        nearme[index].price,
                        nearme[index].status,
                        nearme[index].book_author,
                      );
                    },
                  ),
                )
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Donation',
                      style: TextStyle(color: Colors.purple),
                    ),
                    Text(
                      'View all',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),


              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  width: 30,
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:donation.length,
                    itemBuilder: (BuildContext context, int index) {
                      return newdonatinsngos(
                        donation[index].donationbook_image,
                        donation[index].num_of_books,
                        donation[index].nGO,
                        donation[index].status,
                        donation[index].catagory,
                      );
                    },
                  ),
                )
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



class PriceFilter extends StatefulWidget {
  @override
  _PriceFilterState createState() => _PriceFilterState();
}
class _PriceFilterState extends State<PriceFilter> {
  RangeValues _currentRangeValues = const RangeValues(300, 4995);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications button press
            },
          ),
          IconButton(
            icon: Icon(Icons.account_box),
            onPressed: () {
              // Handle add to cart button press
            },
          ),
        ],
        backgroundColor: Colors.purple,
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
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
                    children: [
                      SizedBox(height: 20.0),
                      Text("Apply Filters",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.5),
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
                                      color: Colors.red,
                                    ),
                                  )),
                                  Text.rich(TextSpan(
                                    text:
                                    "Select the filters so that you can find good results",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.purple,
                                    ),
                                  ))
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shop By Price",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Min Value:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.purple[900],
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.monetization_on,
                                    color: Colors.purple[900],
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Enter Minimum Value",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Maximum Value",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.purple[900],
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.monetization_on,
                                    color: Colors.purple[900],
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Enter Maximum Value",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 1),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 60),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 5,
                                offset: Offset(1, 5),
                              ),
                            ],
                          ),
                          child: RangeSlider(
                            values: _currentRangeValues,
                            min: 1,
                            max: 4995,
                            divisions: 3,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFff0066), Color(0xFFffccff),],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purpleAccent,
                              blurRadius: 5,
                              offset: Offset(2, 3),
                            ),
                          ],
                        ),


                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Book Availabity",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 5),
                            AvailabilityCheckbox(),
                          ],
                        ),


                      ),

                      SizedBox(height: 46),
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
                      SizedBox(height: 46),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.purpleAccent],
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
                          children: [

                            SizedBox(height: 26),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Book Class",
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
                                      child: Text(" Class 1",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Class 1",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Class 2",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Class 2",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Class 3",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Class 3",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Class 4",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Class 4",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Class 5",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Class 5",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Class 6",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Class 6",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Class 7",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Class 7",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Class 8",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Class 8",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Class 9",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Class 9",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Class 10",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Class 10",
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
                                    hintText: "Select book class",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  onChanged: (value) {},
                                ),
                              ],
                            ),


                            SizedBox(height: 26),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Book Semester",
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
                                      child: Text(" Semester 1",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Semester 1",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Semester 2",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Semester 2",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Semester 3",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Semester 3",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Semester 4",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Semester 4",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Semester 5",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Semester 5",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Semester 6",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Semester 6",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Semester 7",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Semester 7",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Semester 8",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "Semester 8",
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
                                    hintText: "Select book semester",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  onChanged: (value) {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 46),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.purpleAccent],
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
                          children: [

                            SizedBox(height: 26),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Book School",
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
                                      child: Text(" School 1",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "School 1",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("School 2",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "School 2",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("School 3",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "School 3",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("School 4",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "School 4",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("School 5",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "School 5",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("School 6",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "School 6",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("School 7",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "School 7",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("School 8",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "School 8",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("School 9",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "School 9",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("School 10",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "School 10",
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
                                    hintText: "Select book School",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  onChanged: (value) {},
                                ),
                              ],
                            ),


                            SizedBox(height: 26),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Book College",
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
                                      child: Text("College 1",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "College 1",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("College 2",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "College 2",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("College 3",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "College 3",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("College 4",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "College 4",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("College 5",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "College 5",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("College 6",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "College 6",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("College 7",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "College 7",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("College 8",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "College 8",
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
                                    hintText: "Select book college",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  onChanged: (value) {},
                                ),
                              ],
                            ),


                            SizedBox(height: 26),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Book University",
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
                                      child: Text("University 1",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "University 1",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("University 2",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "University 2",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("University 3",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "University 3",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("University 4",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "University 4",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("University 5",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "University 5",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("University 6",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "University 6",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("University 7",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "University 7",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("University 8",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),),
                                      value: "University 8",
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
                                    hintText: "Select book university",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  onChanged: (value) {},
                                ),
                              ],
                            ),



                          ],
                        ),
                      ),











                      SizedBox(height: 46),












                      SizedBox(height: 16),

                      SizedBox(height: 16),









                      SizedBox(height: 70),
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
                              color: Colors.purpleAccent.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(1, 5),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            "Apply",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
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


class AvailabilityCheckbox extends StatefulWidget {
  @override
  _AvailabilityCheckboxState createState() => _AvailabilityCheckboxState();
}

class _AvailabilityCheckboxState extends State<AvailabilityCheckbox> {
  bool? inStock = false;
  bool? outOfStock = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pinkAccent.withOpacity(0.2), Colors.purpleAccent.withOpacity(0.2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),

              child: CheckboxListTile(
                title: Text("In Stock"),
                value: inStock,
                onChanged: (bool? value) {
                  setState(() {
                    inStock = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pinkAccent.withOpacity(0.2), Colors.purpleAccent.withOpacity(0.2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CheckboxListTile(
                title: Text("Out of Stock"),
                value: outOfStock,
                onChanged: (bool? value) {
                  setState(() {
                    outOfStock = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}




