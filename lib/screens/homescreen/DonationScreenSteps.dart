import 'package:book_bank/screens/homescreen/homescreen2.dart';
import 'package:flutter/material.dart';
import 'package:book_bank/screens/homescreen/cart.dart';
import 'package:book_bank/screens/homescreen/ProductListing.dart';
import 'package:book_bank/screens/homescreen/DonationScreenSteps.dart';
import 'package:book_bank/screens/homescreen/favouritelist.dart';

class DonationScreen extends StatefulWidget {
  static const String id ='DonationScreen';
  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  int _currentStep = 0;
  TextEditingController _amountController = TextEditingController();

  List<Step> _donationSteps() {
    List<Step> _steps = [
      Step(
        title: Text('Personal Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple,
            )),
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: const [

              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person, color: Colors.purpleAccent,),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Colors.purpleAccent,),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  prefixIcon: Icon(Icons.phone_android_outlined, color: Colors.purpleAccent,),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'NIC number',
                  prefixIcon: Icon(Icons.person, color: Colors.purpleAccent,),
                ),
                style: TextStyle(fontSize: 16),
              ),

            ],
          ),
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Textbooks Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ,color: Colors.purple,)),
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Photos",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),),
              SizedBox(height: 16),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.purple,
                        size: 48,
                      ),
                      Text("Drop your images here to upload",
                        style: TextStyle(
                          fontSize: 15,

                          color: Colors.purple,
                        ), ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'No.of textbooks donating',

                  prefixIcon: Icon(Icons.book, color: Colors.purpleAccent,),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),


              SizedBox(height: 16),
              DropdownButtonFormField(
                items: const [
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
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text('Pick-up Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple,)),
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: const [
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(

                  border: OutlineInputBorder(),
                  hintText: "Robert Robertson, 1234 NW "
                      "Bobcat Lane, St. Robert, MO 65584-5678",
                  prefixIcon: Icon(Icons.location_city, color: Colors.purpleAccent,),
                ),
              ),


              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter State",
                  prefixIcon: Icon(Icons.location_city, color: Colors.purpleAccent,),
                ),
              ),


              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter City",
                  prefixIcon: Icon(Icons.location_city_sharp, color: Colors.purpleAccent,),

                ),
              ),


              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Pincode",
                  prefixIcon: Icon(Icons.numbers, color: Colors.purpleAccent,),

                ),
              ),
            ],
          ),
        ),
        isActive: _currentStep >= 2,
      ),

      Step(
        title: Text('Schedule a Slot for Pick-up',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.purple,)),
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Select Time',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time),
                ),
              ),
            ],
          ),
        ),
        isActive: _currentStep >= 3,
      ),



    ];
    return _steps;
  }

  void _submitDonation() {
    // submit donation code here
    print('Donation submitted with amount: ${_amountController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.purpleAccent,
                    Colors.purple
                  ])
          ),
        ),
        title: Text('Make a donation'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, homescreen2.id);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, homescreen2.id);
            },
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ), //
      body: Theme(
        data: ThemeData(
          primaryColor: Colors.green, // button color
          accentColor: Colors.green, // index color
          canvasColor: Colors.blueGrey, // background color
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Stepper(
                    currentStep: _currentStep,
                    onStepTapped: (step) {
                      setState(() {
                        _currentStep = step;
                      });
                    },
                    onStepContinue: () {
                      if (_currentStep == _donationSteps().length - 1) {
                        _submitDonation();
                      } else {
                        setState(() {
                          _currentStep += 1;
                        });
                      }
                    },
                    onStepCancel: () {
                      if (_currentStep == 0) {
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          _currentStep -= 1;
                        });
                      }
                    },
                    steps: _donationSteps(),
                    controlsBuilder: (BuildContext context, ControlsDetails controlsDetails) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: controlsDetails.onStepContinue,
                            child: Text('NEXT'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                            ),
                          ),
                          TextButton(
                            onPressed: controlsDetails.onStepCancel,
                            child: Text('BACK'),
                            style: TextButton.styleFrom(
                              primary: Colors.purple,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: (){},
                        child: Text('NEXT'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ConfirmationScreen()),
                          );
                        },
                        child: Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purpleAccent,
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16.0),
                ),

              ],
            ),
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

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'BookBank',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Easiest way to donate your textbooks',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple),
                  ),
                  SizedBox(height: 16),
                  Image.network('https://cdn.pixabay.com/photo/2012/05/07/02/13/accept-47587__340.png'),
                  SizedBox(height: 16),
                  Text(
                    'Thank you, Ghilman',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Thanks for donating your textbooks. Your support is vital as it allows us to reach more underprivileged students in Pakistan in need of educational help. You will receive a confirmation notification soon.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16,color: Colors.purpleAccent),
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, homescreen2.id);
                      Text(
                        'Thanks for donating your textbooks. Your support is vital as it allows us to reach more underprivileged students in Pakistan in need of educational help. You will receive a confirmation notification soon.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      );
                    },
                    child: Text('Done'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purpleAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class DonationScreenSteps extends StatelessWidget {
  static const String id = 'DonationScreenSteps';
  double getProportionalScreenWidth(BuildContext context, double percentage) {
    // Get the screen width using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    // Calculate the proportional screen width based on the input percentage
    double proportionalWidth = screenWidth * percentage / 100;
    return proportionalWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.purpleAccent,
                    Color(0xFFcc99ff),
                  ])
          ),
        ),
        title: Text(''),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ), //
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 36),
                Text(
                  'BookBank',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.purple),
                ),
                SizedBox(height: 10),
                Text(
                  'Easiest way to donate your textbooks',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple),
                ),
                SizedBox(height: 16),
                Image.network('https://img.freepik.com/premium-vector/tiny-male-female-characters-put-books-stationery-huge-donation-box-happy-kids-with-heart-hands-gratitude-sponsors-humanitarian-aid-solidarity-cartoon-people-vector-illustration_87771-13456.jpg'),
                SizedBox(height: 16),
                Text(
                  'Steps to donate your textbooks',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                    child: Row(
                      children: [
                        SizedBox(
                          width: getProportionalScreenWidth(context, 30),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                  vertical: 1,
                                ),
                                child: Image.network(
                                  'https://img.freepik.com/premium-vector/book-donation-cardboard-box-full-different-textbooks_189033-1812.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionalScreenWidth(context, 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 11,),
                                child: Text(
                                  "1. Prepare your textbooks",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 11,),
                                child: Text(
                                  'Collect all your textbooks and arrange it well. Get your books packed and put it in a box safety.',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[

                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: getProportionalScreenWidth(context, 33),
                          child: AspectRatio(
                            aspectRatio: 0.90,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                  vertical: 1,
                                ),
                                child: Image.network(
                                  'https://languagefeatures.weebly.com/uploads/8/0/7/3/8073269/7354600.gif?1378426545',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionalScreenWidth(context, 40),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 3,),
                                  child: Text(
                                    "2. Submit textbooks donation",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 3,),
                                  child: Text(
                                    'Compelete the donation form with required information and submit it.',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
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
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: getProportionalScreenWidth(context, 33),
                              child: AspectRatio(
                                aspectRatio: 0.88,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                      vertical: 1,
                                    ),
                                    child: Image.network(
                                      'https://cdn.shopify.com/app-store/listing_images/a025a29145b1f0be4ef5692148f05569/icon/CLvai6LUx_cCEAE=.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getProportionalScreenWidth(context, 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5,),
                                    child: Text(
                                      "3. Door-step free pickup",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5,),
                                    child: Text(
                                      'You schedule a slot for pickup and provide your pickup address. We will arrange pickup for you  from your door-step.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[

                        SizedBox(
                          width: getProportionalScreenWidth(context, 33),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                  vertical: 1,
                                ),
                                child: Image.network(
                                  'https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/77029/police-badge-clipart-md.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionalScreenWidth(context, 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12,),
                                child: Text(
                                  "4. Earn badges as your reward",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12,),
                                child: Text(
                                  'Once you donate your textbooks you will get badges when you reach certain levels',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ],
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DonationScreen()),
                    );                },
                  child: Text('Got it'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purpleAccent,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
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