import 'package:flutter_demo/core/models/contact.dart';
import 'package:flutter_demo/core/scoped_models/home_model.dart';
import 'package:flutter_demo/enums/view_state.dart';
import 'package:flutter_demo/service_locator.dart';
import 'package:flutter_demo/ui/views/base_view.dart';
import 'package:flutter_demo/ui/views/contactForm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/widgets/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeView> {
  List<Contact> contacts = [];

  var myAppModel = locator<HomeModel>();
  @override
  void initState() {
    super.initState();
    if (!myAppModel.loaded) myAppModel.getContacts(_getUser());
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      builder: (context, child, model) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Appbar(),
        ),
        body: ListView.builder(
          itemCount: myAppModel.contacts.length,
          itemBuilder: _contactCard,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactFormView()));
          },
          child: Icon(Icons.navigation_rounded),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }

  Widget _getBodyUi(ViewState state) {
    switch (state) {
      case ViewState.Busy:
        return CircularProgressIndicator();
      case ViewState.Retrieved:
      default:
        return Text('');
    }
  }

  Widget _contactCard(BuildContext context, int index) {
    return InkWell(
      splashColor: Colors.blueGrey,
      onTap: () async {
        Navigator.of(context).pushNamed('details',
            arguments: myAppModel.contacts[index].contact.contact_id);
      },
      child: Card(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.cyan[300],
                child: Text(
                  (myAppModel.contacts[index].contact.name.length != 0)
                      ? myAppModel.contacts[index].contact.name[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  width: 140.0,
                  child: Text(
                    myAppModel.contacts[index].contact.name,
                    // textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int user = (prefs.getInt('userID') ?? -1);
    return user;
  }
}
