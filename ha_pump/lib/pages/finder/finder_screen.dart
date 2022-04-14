import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ha_pump/pages/finder/components/background.dart';
import 'package:ha_pump/pages/login/login_screen.dart';
import 'package:ha_pump/pages/map/map_screen.dart';
import 'package:ha_pump/model/gas_station.dart';
import 'package:ha_pump/theme.dart';

class Finder extends StatefulWidget {
  const Finder({Key? key}) : super(key: key);
  @override
  _FinderState createState() => _FinderState();
}

class _FinderState extends State<Finder> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isDefault = true;
  String searchQuery = "";
  late GasStation selectedStation;
  final gasStationsRef = FirebaseFirestore.instance
      .collection('gas_stations')
      .withConverter<GasStation>(
        fromFirestore: (snapshots, _) => GasStation.fromJson(snapshots.data()!),
        toFirestore: (gasStation, _) => gasStation.toJson(),
      );

  @override
  Widget build(BuildContext context) {
    auth.idTokenChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        }));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            "Ha Pump",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: kPrimaryColor,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                  child: const Text(
                    "Sign out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  )),
            ),
          )
        ],
      ),
      backgroundColor: kPrimaryColor,
      body: isDefault ? defaultBody() : detailPage(),
    );
  }

  Widget defaultBody() {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot<GasStation>>(
        stream: gasStationsRef
            .where('name', isGreaterThanOrEqualTo: searchQuery)
            .where(
              'name',
              isLessThan: searchQuery + 'z',
              // add 'z' for make the boundary
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final gasStations = snapshot.requireData;

          return Background(
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.02),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    onChanged: (String value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search, color: Colors.black),
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Expanded(
                  child: ListView.builder(
                    itemCount: gasStations.size,
                    itemBuilder: (context, index) {
                      final gasStation = gasStations.docs[index].data();
                      return GestureDetector(
                        onTap: () => {
                          setState(() {
                            isDefault = false;
                            selectedStation = gasStation;
                          }),
                        },
                        child: buildImageInteractionCard(gasStation),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget detailPage() {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.02),
          buildDetailCard(selectedStation),
        ],
      ),
    );
  }

  Widget buildImageInteractionCard(GasStation gasStation) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(5, 5),
          )
        ],
      ),
      margin: EdgeInsets.only(
          left: size.width * 0.06,
          right: size.width * 0.06,
          bottom: size.width * 0.03),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Ink.image(
              image: NetworkImage(
                gasStation.imageUrl[0],
              ),
              height: 210,
              fit: BoxFit.cover,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    gasStation.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "${gasStation.range} km.",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailCard(GasStation gasStation) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(5, 5),
          )
        ],
      ),
      margin: EdgeInsets.only(
          left: size.width * 0.06,
          right: size.width * 0.06,
          bottom: size.width * 0.03),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_circle_left),
                        onPressed: () {
                          setState(() {
                            isDefault = true;
                          });
                        },
                      ),
                      Text(
                        gasStation.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Text(
                      "${gasStation.range} KM.",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Ink.image(
              image: NetworkImage(
                gasStation.imageUrl[0],
              ),
              height: 210,
              fit: BoxFit.cover,
            ),
            Ink.image(
              image: NetworkImage(
                gasStation.imageUrl[1],
              ),
              height: 210,
              fit: BoxFit.cover,
            ),
            Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.map_outlined),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Map(gasStation.latLng)));
                        },
                      ),
                      const Text("Map Link"),
                    ],
                  ),
                  Text(
                    gasStation.address,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.phone),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Text(gasStation.contact),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
