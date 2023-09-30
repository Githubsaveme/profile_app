import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  List<SalesData> saleList = [];
  List<YearModel> yearModelList = [];

  String dropValue = '';
  String dropValue2 = '';
  bool isSelected = false;
  bool isSelected2 = false;
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
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    yearFunction();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey,
            Colors.black.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.width * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Load Data")),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Plot Data"))
                  ],
                ),
                showCharts(),
                Row(
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                          hint: Text(
                            dropValue.isNotEmpty ? dropValue : 'Select Cable',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                          items: yearModelList
                              .map((e) => DropdownMenuItem(
                                    value: e.yearName,
                                    child: Text(
                                      e.yearName,
                                      style: const TextStyle(
                                        color: Colors.black,
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
                    ),
                    const Expanded(child: SizedBox()),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                          hint: Text(
                            dropValue2.isNotEmpty ? dropValue2 : 'Select Cable',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                          items: yearModelList
                              .map((e) => DropdownMenuItem(
                                    value: e.yearName,
                                    child: Text(
                                      e.yearName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            dropValue2 = value!;
                            isSelected2 = !isSelected2;
                            setState(() {});
                          }),
                    ),
                  ],
                ),
                showLineChart(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showCharts() {
    return SfCartesianChart(
        title: ChartTitle(
            text: 'Inversion velocity',
            textStyle: const TextStyle(
              color: Colors.yellowAccent,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700,
            )),
        plotAreaBorderColor: Colors.yellowAccent,
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(),
        // legend: const Legend(isVisible: true),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
        series: <ChartSeries<SalesData, String>>[
          ColumnSeries<SalesData, String>(
            dataLabelSettings:
                DataLabelSettings(color: Colors.yellowAccent.shade200),
            color: Colors.yellowAccent.shade100,
            dataSource: isSelected ? chartData : chartData2,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
          ),
        ]);
  }

  Widget showLineChart() {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(
            arrangeByIndex: true, autoScrollingMode: AutoScrollingMode.start),
        // Chart title
        title: ChartTitle(
            text: 'Prediction',
            textStyle: const TextStyle(
              color: Colors.yellowAccent,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700,
            )),
        // Enable legend
        //legend: const Legend(isVisible: true),
        // Enable tooltip
        tooltipBehavior: _tooltipBehavior,
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
              color: Colors.yellowAccent,
              dataSource: isSelected2 ? chartData : chartData2,
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
              // Enable data label
              dataLabelSettings: const DataLabelSettings(
                  isVisible: true, color: Colors.yellowAccent))
        ]);
  }

  void yearFunction() {
    yearModelList.add(YearModel(yearName: 'Cable 1'));
    yearModelList.add(YearModel(yearName: 'Cable 2'));
    yearModelList.add(YearModel(yearName: 'Cable 3'));
    yearModelList.add(YearModel(yearName: 'Cable 4'));
    yearModelList.add(YearModel(yearName: 'Cable 5'));
    yearModelList.add(YearModel(yearName: 'Cable 6'));
    yearModelList.add(YearModel(yearName: 'Cable 7'));
    yearModelList.add(YearModel(yearName: 'Cable 8'));
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
