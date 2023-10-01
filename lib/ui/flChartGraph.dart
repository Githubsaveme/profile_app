import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profile_app/ui/graphScreen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: DateTime(2015, 1, 1, 1), yValue: 1.13),
    ChartSampleData(x: DateTime(2015, 1, 2, 2), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 1, 3, 3), yValue: 1.08),
    ChartSampleData(x: DateTime(2015, 1, 4, 4), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 1, 5, 5), yValue: 1.1),
    ChartSampleData(x: DateTime(2015, 1, 6, 6), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 1, 7, 7), yValue: 1.1),
    ChartSampleData(x: DateTime(2015, 1, 8, 8), yValue: 1.12),
    ChartSampleData(x: DateTime(2015, 1, 9, 9), yValue: 1.16),
    ChartSampleData(x: DateTime(2015, 1, 10, 10), yValue: 1.1),
  ];
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];
  List<YearModel> yearModelList = [];

  bool showAvg = false;
  bool predictionVar = false;

  String dropValue = '';
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    yearFunction();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          "Graph",
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.04,
              color: Colors.black),
        ),
        actions: [Image.asset('asset/image/splash.gif')],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    )),
                onPressed: () {},
                child: const Text(
                  "Load Data",
                  style: TextStyle(color: Colors.white),
                )),
            const Expanded(child: SizedBox()),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    )),
                onPressed: () {},
                child: const Text(
                  "Plot Data",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                  hint: Text(
                    dropValue.isNotEmpty ? dropValue : 'Select Cable',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
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
            Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.70,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 18,
                      left: 12,
                      top: 24,
                      bottom: 12,
                    ),
                    child: LineChart(
                      showAvg ? avgData() : mainData(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 34,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        showAvg = !showAvg;
                      });
                    },
                    child: Text(
                      'avg',
                      style: TextStyle(
                        fontSize: 12,
                        color: showAvg
                            ? Colors.black.withOpacity(0.5)
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          predictionVar ? Colors.blue : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      )),
                  onPressed: () {
                    predictionVar = !predictionVar;
                    setState(() {});
                  },
                  child: Text(
                    "Prediction",
                    style: TextStyle(
                        color: predictionVar ? Colors.white : Colors.white),
                  )),
            ),
            predictionVar
                ? SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    series: <ChartSeries<ChartSampleData, DateTime>>[
                        LineSeries<ChartSampleData, DateTime>(
                            dataSource: chartData,
                            xValueMapper: (ChartSampleData sales, _) => sales.x,
                            yValueMapper: (ChartSampleData sales, _) =>
                                sales.yValue)
                      ])
                : Image.asset('asset/image/graph.png')
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;
    /* DateTime now = DateTime.now();
    String dateFormatted = DateFormat.MMM().format(now);
    text = Text(dateFormatted);*/
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      space: 1,
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.green,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 5.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
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

class ChartSampleData {
  late DateTime x;
  late double yValue;

  ChartSampleData({required this.x, required this.yValue});
}
