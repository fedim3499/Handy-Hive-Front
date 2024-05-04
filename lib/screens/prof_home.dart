import 'package:flutter/material.dart';
import 'package:flutter_front/screens/Prof_profile.dart';
import 'package:flutter_front/screens/work_requests.dart';

class ProfHome extends StatefulWidget {
  const ProfHome({Key? key}) : super(key: key);

  @override
  State<ProfHome> createState() => _ProfHomeState();
}

class _ProfHomeState extends State<ProfHome> {
  int _selectedIndex = 0;
  int requestsCount = 0; // Initialize requestsCount to 0

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getPage(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return ProfHomeBox(requestsCount: requestsCount); // Show ProfHomeBox on the Home page
      case 1:
        return Center(child: Text('This is the Chat Page'));
      case 2:
        return ProfProfile();
      default:
        return Container();
    }
  }
}

class ProfHomeBox extends StatelessWidget {
  final int requestsCount;

  const ProfHomeBox({Key? key, required this.requestsCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkRequestsScreen()),
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          margin: EdgeInsets.only(top: 20.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'See who needs your help',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                'Requests: $requestsCount', // Show requestsCount variable
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
