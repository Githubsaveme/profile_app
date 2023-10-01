import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  List<YearModel> yearModelList = [];
  final List<ChartData> chartData = [
    ChartData(DateTime(2015, 1), 6),
    ChartData(DateTime(2016, 1), 11),
    ChartData(DateTime(2017, 1), 9),
    ChartData(DateTime(2018, 1), 14),
    ChartData(DateTime(2023, 1), 10),
  ];

  String dropValue = '';
  String dropValue2 = '';
  bool isSelected = false;
  bool isSelected2 = false;
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
    return Scaffold(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget showCharts() {
    return SfCartesianChart(
      enableAxisAnimation: true,
      tooltipBehavior: TooltipBehavior(),
      zoomPanBehavior: ZoomPanBehavior(),
      crosshairBehavior: CrosshairBehavior(),
      trackballBehavior:
          TrackballBehavior(activationMode: ActivationMode.singleTap),
      primaryXAxis: DateTimeCategoryAxis(
          intervalType: DateTimeIntervalType.months,
          rangePadding: ChartRangePadding.round,
          interval: 2,
          interactiveTooltip: const InteractiveTooltip(
              color: Colors.green,
              canShowMarker: true,
              connectorLineColor: Colors.greenAccent),
          minimum: DateTime(2014, 1),
          maximum: DateTime(2024, 1),
          autoScrollingMode: AutoScrollingMode.start,
          autoScrollingDeltaType: DateTimeIntervalType.auto),
      series: <ChartSeries<ChartData, DateTime>>[
        LineSeries<ChartData, DateTime>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y),
      ],
    );
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

class YearModel {
  String yearName = '';

  YearModel({required this.yearName});
}

class ChartData {
  ChartData(this.x, this.y);

  final DateTime x;
  final double y;
}
