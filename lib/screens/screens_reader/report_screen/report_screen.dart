import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/screens/screens_reader/report_screen/chart.dart';

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int activeDay = 3;
  bool showAvg = false;
  String selectType = "Day";

  List expenses = [
    {
      "icon": Icons.arrow_back_ios,
      "color": Colors.blue,
      "label": "Income",
      "cost": "\$6593.75"
    },
    {
      "icon": Icons.arrow_forward_ios,
      "color": Colors.red,
      "label": "Expense",
      "cost": "\$2645.50"
    }
  ];

  List days = [
    {"label": "Sun", "day": "28"},
    {"label": "Mon", "day": "29"},
    {"label": "Tue", "day": "30"},
    {"label": "Wed", "day": "1"},
    {"label": "Thu", "day": "2"},
    {"label": "Fri", "day": "3"},
    {"label": "Sat", "day": "4"},
  ];
  List months = [
    {"label": "2018", "day": "Jan"},
    {"label": "2018", "day": "Feb"},
    {"label": "2018", "day": "Mar"},
    {"label": "2018", "day": "Apr"},
    {"label": "2018", "day": "May"},
    {"label": "2018", "day": "Jun"},
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Sales Report'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(right: 20, top: 20),
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
                child: DropdownButton<String>(
                  value: selectType,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (newValue) {
                    setState(() {
                      selectType = newValue!;
                    });
                  },
                  underline: Container(),
                  items: [
                    DropdownMenuItem<String>(
                      value: "Day",
                      child: Text("Day"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Month",
                      child: Text("Month"),
                    ),
                    DropdownMenuItem<String>(
                      value: "Year",
                      child: Text("Year"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Net balance",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Color(0xff67727d),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "\$2446.90",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: SizedBox(
                          width: (size.width - 20),
                          height: 150,
                          child: LineChart(
                            mainData(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  width: (size.width - 60) / 2,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 10,
                        blurRadius: 3,
                        // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Income",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "\$6593.75",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: (size.width - 60) / 2,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 10,
                        blurRadius: 3,
                        // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Expense",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "\$6593.75",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
