import 'package:flutter/material.dart';

import 'CommentBox.dart';
import 'package:book_bank/screens/homescreen/cart.dart';


class ProductPage2 extends StatefulWidget {
  static const String id = 'ProductPage2';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class ProductImageSelector extends StatefulWidget {
  final List<String> images;

  const ProductImageSelector({Key? key, required this.images})
      : super(key: key);

  @override
  _ProductImageSelectorState createState() => _ProductImageSelectorState();
}

class _ProductImageSelectorState extends State<ProductImageSelector> {
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.images.length; i++)
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedImageIndex = i;
                  });
                },
                icon: Image.network(
                  widget.images[i],
                  width: 50,
                  height: 50,
                ),
              ),
          ],
        ),
        Image.network(
          widget.images[_selectedImageIndex],
          width: 200,
          height: 200,
        ),
      ],
    );
  }
}

class _ProductPageState extends State<ProductPage2> {
  // Define variables to hold book data
  String bookTitle = "The Catcher in the Rye";
  String bookState = "Sale";
  String bookDescription =
      "The Catcher in the Rye is a novel by J. D. Salinger, partially published in serial form in 1945–1946 and as a novel in 1951. It was originally intended for adults but is often read by adolescents for its themes of angst, alienation, and as a critique on superficiality in society.";
  double bookPrice = 9.99;
  double bookRatings = 4.5;
  String bookImage =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/The_Catcher_in_the_Rye_%281951%2C_first_edition_cover%29.jpg/640px-The_Catcher_in_the_Rye_%281951%2C_first_edition_cover%29.jpg";
  String name = 'Asaad Mehmood';
  String location = 'Dha phase 9, near Shell pump ';
  double rating = 5;
  String imageUrl = 'https://www.shareicon.net/data/2015/08/07/81317_man_512x512.png';

  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf7f7f7),
      appBar: AppBar(
        title: const Text(
          "Book details",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.25),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.chat),
            tooltip: 'chat Icon',
            color: Colors.purple,
            onPressed: () {},
          ), //IconButton
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            tooltip: 'add shopping cart Icon',
            color: Colors.purple,
            onPressed: () {
              Navigator.pushNamed(context, cart.id);
            },
          ), //IconButton
        ],
        //<Widget>[]
        leading: BackButton(
          color: Colors.purple,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageSelector(
              images: [
                'https://www.peterharrington.co.uk/blog/wp-content/uploads/2023/02/158632-Salinger-scaled.jpg',
                'https://www.pluggedin.com/wp-content/uploads/2020/01/catcher-in-the-rye-cover-image-682x1024.jpeg',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnRpYyEz6Uy64CvJiAsISzmmUFi_NEzXlFwZ3e1Diyw8ly3UV2AlrClO_xfYDlkflLt6Y&usqp=CAU',
              ],
            ),

            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(bookImage),
                  fit: BoxFit.cover,
                ),
              ),


              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookTitle,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        Text(
                          bookState,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),

                        SizedBox(height: 5),
                        Text(
                          "\$${bookPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFff9900),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            SizedBox(width: 5),
                            Text(
                              bookRatings.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                bookDescription,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [

                  DataColumn(
                    label: Text(
                      'Publication Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Language',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Number of Pages',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'ISBN Number',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Catergory',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  DataColumn(
                    label: Text(
                      'Condition',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [

                      DataCell(
                        Text('January 1, 2022'),
                      ),
                      DataCell(
                        Text('English'),
                      ),
                      DataCell(
                        Text('256'),
                      ),
                      DataCell(
                        Text('978-0-306-40615-7'),
                      ),
                      DataCell(
                        Text('Novel, Bildungsroman, '
                            'Young adult fiction, '),
                      ),
                      DataCell(
                        Text('New'),
                      ),
                    ],
                  ),


                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          location,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 16.0,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),


            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, cart.id);

                    setState(() {
                      itemCount++;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Added to cart!',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                  ),
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {

                    // Implement chat functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Chat functionality is not implemented yet.',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purpleAccent,
                  ),
                  child: Text(
                    "Chat",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Container(
            //   height: 10,
            //   width: 10,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.stretch,
            //       children: [
            //         Expanded(child: Placeholder()),
            //         SizedBox(height: 16),
            //         Container(
            //             height: 10,
            //             width: 10,
            //             child: ),
            //       ],
            //     ),
            //   ),
            // ),

            CommentBox(),
            SizedBox(height: 30,),
          ],



        ),

      ),









      bottomNavigationBar: BottomAppBar(

        color: Colors.purple,
        shape: CircularNotchedRectangle(),

        child: Container(

          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (itemCount > 0) {
                      itemCount--;
                    }
                  });
                },
                icon: Icon(Icons.remove),
                color: Colors.white,
              ),
              Text(
                itemCount.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    itemCount++;
                  });
                },
                icon: Icon(Icons.add),
                color: Colors.white,
              ),
            ],
          ),
        ),



      ),



    );
  }
}
