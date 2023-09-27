import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  List<SalesData> saleList = [];
  List<YearModel> yearModelList = [];

  String dropValue = '';
  bool isSelected = false;
  final List<SalesData> chartData = <SalesData>[
    SalesData('Jan', 32),
    SalesData('Feb', 1),
    SalesData('Mar', 33),
    SalesData('Jun', 31),
    SalesData('July', 36),
    SalesData('Aug', 12),
    SalesData('Sep', 10),
    SalesData('Oct', 33),
    SalesData('Nov', 22),
    SalesData('Dec', 23),
  ];
  final List<SalesData> chartData2 = <SalesData>[
    SalesData('Jan', 13),
    SalesData('Feb', 10),
    SalesData('Mar', 20),
    SalesData('Aug', 31),
  ];

  @override
  void initState() {
    super.initState();
    yearFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Graph'), actions: [
        DropdownButtonHideUnderline(
          child: DropdownButton2(
              hint: Text(dropValue.isNotEmpty ? dropValue : 'Select year'),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
              items: yearModelList
                  .map((e) => DropdownMenuItem(
                        value: e.yearName,
                        child: Text(
                          e.yearName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              onChanged: (String? value) {
                dropValue = value!;
                isSelected = !isSelected;
                setState(() {});
              }),
        )
      ]),
      body: showCharts(),
    );
  }

  Widget showCharts() {
    return SfCartesianChart(
        backgroundColor: Colors.red.withOpacity(0.05),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
        series: <ChartSeries<SalesData, String>>[
          ColumnSeries<SalesData, String>(
            dataSource: isSelected ? chartData : chartData2,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
          ),
        ]);
  }

  void yearFunction() {
    yearModelList.add(YearModel(yearName: '2021'));
    yearModelList.add(YearModel(yearName: '2022'));
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class YearModel {
  String yearName = '';

  YearModel({required this.yearName});
}
