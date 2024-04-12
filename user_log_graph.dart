import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'user_log_graph_datamodel.dart';
import '../menu_list_after_login.dart';
//import '../server.dart';

class UserLogGraph extends StatelessWidget {
  const UserLogGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 50, 5, 210),
          foregroundColor: Colors.white,
          title: Center(child: Text('Data Management Sytem')),
        ),
        //body: NextPage_02_Pref(),
        body: MyProject(),
      ),
    );
  }
}

class MyProject extends StatefulWidget {
  const MyProject({Key? key}) : super(key: key);

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  //Timer? _timer;
  var sum1a;
  var sum01;
  
  var count2;
  double y3a = 600; // Default, if (count3 < 10)

  //inisialisasi variabel
  List<UserLogGraphDataModel> dataList = [];
  bool loading = true;

  @override
  void initState() {
    _getData();
    _queryTotal();
    //_timer = Timer.periodic(const Duration(seconds: 5), (timer) => _getData());
    super.initState();
  }

  Future<void> _queryTotal() async {
    final url01 = Uri.parse(
      //'$server/user_total.php',
      'https://mediumsitompul.com/basicmobile/user_log_total.php',
      //'$server/user_total.php',
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

  //===========================================================================================
  // FUNCTION
  void _getData() async {
    //get data api
    var response = await http.get(Uri.parse(
        //"https://mediumsitompul.com/daman03/pareto_kec.php?auth=kjgdkhdfldfguttedfgr")); //DETAIL OK
        //"$server/pareto_kec.php?auth=kjgdkhdfldfguttedfgr")); //DETAIL OK
        //"https://mediumsitompul.com/basicmobile/data/pareto_kec.php?auth=kjgdkhdfldfguttedfgr")); //OK RUNNING WELL
        //"https://mediumsitompul.com/basicmobile/data/data_graph_kec.php?auth=kjgdkhdfldfguttedfgr")); //OK RUNNING WELL
        "https://mediumsitompul.com/basicmobile/user_log_graph.php?auth=kjgdkhdfldfguttedfgr")); //OK RUNNING WELL

    //convert data string to data json object & save to variable data
    List data = json.decode(response.body);
    print(data);

    setState(() {
      //memasukan data json ke dalam format model in (data_model.dart)
      dataList = data1ModelFromJson(
          data); //link to data_model.dart. dataList menjadi format data Model
      loading = false;
    });
  }


  //===========================================================================================
  Future<void> _queryCount3() async {
    final url2 = Uri.parse(
      //'https://mediumsitompul.com/basicmobile/data/query_count3a.php',
      //'https://mediumsitompul.com/basicmobile/quickcount/data_graph_tps_kec_.php?auth=kjgdkhdfldfguttedfgr',
      'https://mediumsitompul.com/basicmobile/user_log_graph.php?auth=kjgdkhdfldfguttedfgr',
      

      //'$server/query_count3a.php',
    );
    var response2 = await http.post(url2, body: {});
    var datauser2 = jsonDecode(response2.body);

    if (datauser2.isEmpty) {
      setState(() {
        count2 = "0";
      });
    } else {
      setState(() {
        // count2 = datauser2[0]['jumlah2'];
        // int count3 = int.parse(count2);
        // double count3a_;
        // count3a_ = count3 / 2; // 8/2 = 4
        // double var1 = 600;
        // y3a = var1 + (count3a_ - 1) * 200;

        //count2 = datauser2[0]['jumlah2'];
        count2 = datauser2[0]['count'];

        int count3 = int.parse(count2);
        double count3a_;
        count3a_ = count3 / 1; // 8/2 = 4
        //double var1 = 600;
        //y3a = var1 + (count3a_ - 1) * 100;
        y3a = (count3a_) * 680;

        // //...............................
        // if (count3 >= 50) {
        //   y3a = 2700;
        // } else if (count3 >= 48) {
        //   y3a = 2600;
        // } else if (count3 >= 46) {
        //   y3a = 2500;
        // } else if (count3 >= 44) {
        //   y3a = 2400;
        // } else if (count3 >= 42) {
        //   y3a = 2300;
        // } else if (count3 >= 40) {
        //   y3a = 2200;
        // } else if (count3 >= 38) {
        //   y3a = 2100;
        // } else if (count3 >= 36) {
        //   y3a = 2000;
        // } else if (count3 >= 34) {
        //   y3a = 1900;
        // } else if (count3 >= 32) {
        //   y3a = 1800;
        // } else if (count3 >= 30) {
        //   y3a = 1700;
        // } else if (count3 >= 28) {
        //   y3a = 1600;
        // } else if (count3 >= 26) {
        //   y3a = 1500;
        // } else if (count3 >= 24) {
        //   y3a = 1400;
        // } else if (count3 >= 22) {
        //   y3a = 1300;
        // } else if (count3 >= 20) {
        //   y3a = 1200;
        // } else if (count3 >= 18) {
        //   y3a = 1600;
        // } else if (count3 >= 16) {
        //   y3a = 1000;
        // } else if (count3 >= 14) {
        //   y3a = 900;
        // } else if (count3 >= 12) {
        //   y3a = 800;
        // } else if (count3 >= 10) {
        //   y3a = 700;
        // }

        //.................................
      });
    }
  }

  //===========================================================================================

  ///

  //===========================================================================================
  //setting diagram/chart

  List<charts.Series<UserLogGraphDataModel, String>> _createSampleData() {
    return [

      charts.Series<UserLogGraphDataModel, String>(

          domainFn: (UserLogGraphDataModel _DataModel, _) =>
              //_DataModel.username1 + "\n" +
              "${_DataModel.username1} \n"
              //_DataModel.name1,
              "${_DataModel.name1}",

          measureFn: (UserLogGraphDataModel _DataModel, _) =>
              _DataModel.count1,
          id: 'name1',

          data: dataList,
          labelAccessorFn: (UserLogGraphDataModel _DataModel, _) =>
              '\Jlh  ${_DataModel.count1.toString()}')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            //height: y3a,
            height: 680,

            padding: const EdgeInsets.all(15),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    const Text(
                      "List of User Log\n(Log / Username)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueGrey),
                    ),
                    Center(
                      child: Text(
                        "Grand Total = " + sum01.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                    Expanded(
                      child: charts.BarChart(
                        barRendererDecorator:
                            charts.BarLabelDecorator<String>(),
                        domainAxis: const charts.OrdinalAxisSpec(),
                        vertical: false, //For Chart Horizontal
                        _createSampleData(),
                        animate: false,
                        //animate: true,
                      ),
                    ),
                    // Text(
                    //   "   Grand Total = " + sum1a.toString(),
                    //   style: TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.blue),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ), //container

      //................... floatingActionButton >>> IN SCAFFOLD() ................
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          print('Tombol Reffresh di pencettt');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuListAfterLogin(),
              ));
        }),
        tooltip: 'Reload data',
        child: const Icon(Icons.ac_unit),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
      ),
      //...........................................................................
    );
  }
}
