import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_list_datamodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'server.dart';
import 'menu_list_after_login.dart';

//.................................................
class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

//.......................................................batas

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  }); //new

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool error = false, dataloaded = false;
  //var data;
  int n = 0;
  var sum01;
  var data2;

  //..................................
  late SharedPreferences pref;
  late String username1 = "";
  late String namamu1 = "";
  late String username1a = "";

  Future<void> initial() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      username1 = pref.getString('username').toString();
      namamu1 = pref.getString('namamu').toString();
    });
  }

//..........................................................................
  @override
  void initState() {
    initial();
    _queryUser();
    // _queryTps();
    // _queryTotalSuara();
    loaddata();
    super.initState();
  }

  //===========================================================================================
  Future<void> _queryUser() async {
    final url01 = Uri.parse(
      //'$server/user_total.php',
      //'https://mediumsitompul.com/basicmobile/user_total.php',
      '$server/user_total.php',
    );
    var response = await http.post(url01, body: {});
    var datauser = jsonDecode(response.body);

    if (datauser.isEmpty) {
      setState(() {
        sum01 = "0";
      });
    } else {
      setState(() {
        sum01 = datauser[0]['jumlah'];
      });
    }
  }

//..............................................................................
  void loaddata() {
    Future.delayed(Duration.zero, () async {
      setState(() {
        //MEDIUM NEW
        var username1a = username1;
        print("username1a");
        print(username1a);
      });

      var dataurl = Uri.parse(
          "https://mediumsitompul.com/basicmobile/user_list.php?auth=kjgdkhdfldfguttedfgr");

      var res = await http.post(Uri.parse(dataurl.toString()));
      //..........................................................................

      if (res.statusCode == 200) {
        setState(() {
          data2 = json.decode(res.body);
          dataloaded = true;
          n = 0;
        });
      } else {
        //there is error
        setState(() {
          error = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 50, 5, 210),
        foregroundColor: Colors.white,
        title: Center(child: Text('USER LIST')),
      ),
      //appBar: AppBar(title: Center(child: Text(namamu1 + " / " + username1))),

      //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      body: Container(
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),

            Center(
              child: Text(
                "Total user = " + sum01.toString(),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Table(
                border: TableBorder.symmetric(
                    inside: const BorderSide(width: 0, color: Colors.blue),
                    outside: const BorderSide(width: 0)),
                columnWidths: const {
                  0: FractionColumnWidth(0.2),
                  1: FractionColumnWidth(0.8),
                },
                //..........................................................................
                children: const [
                  TableRow(children: [
                    Text(
                      "\nNo",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "\nTEAM SUCCESS DESCRIPTION\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ])
                ],
                //..........................................................................
              ),
            ),

            //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
            Container(
              padding: const EdgeInsets.all(15),
              //check if data is loaded, if loaded then show datalist on child
              child: dataloaded
                  ? dataList()
                  : const Center(
                      //if data is not loaded then show progress
                      child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
      //.............................................................
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          print('Tombol Reffresh di pencettt');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const MenuListAfterLogin(), //What is that?
              ));
        }),
        tooltip: 'Reload data',
        child: const Icon(Icons.ac_unit),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
      ),
      //....................................................................................
    );
  }

  Widget dataList() {
    if (data2["error"] != null) {
      return Text(data2["errmsg"]);
    } else {
      List<UserListDataModel> namelist =
          List<UserListDataModel>.from(data2["data1"].map((i) {
        return UserListDataModel.fromJSON(i);
      }));

      return Table(
        border: TableBorder.symmetric(
            inside: const BorderSide(width: 0, color: Colors.blue),
            outside: const BorderSide(width: 0)),
        columnWidths: const {
          0: FractionColumnWidth(0.2),
          1: FractionColumnWidth(0.8),
        },
        children: namelist.map((datamodelUser1) {
          n++;

          return TableRow(//return table row in every loop
              children: [
            TableCell(
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Center(
                        child: Text(
                      "\n ${datamodelUser1.idy} \n",
                      style: const TextStyle(color: Colors.black38),
                    )))),
            TableCell(
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () {},
                      child: Text('Name: ${datamodelUser1.name}.\n'
                          'Phone: ${datamodelUser1.username}.\n'
                          'Email: ${datamodelUser1.email}.\n'
                          'DateTime: ${datamodelUser1.datetime1}.\n'),
                    ))),
          ]);
        }).toList(),
      );
    }
  }
}
