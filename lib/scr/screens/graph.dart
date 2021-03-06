import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:HeartDoc/scr/models/user.dart';
import 'package:HeartDoc/scr/screens/search.dart';
import 'package:HeartDoc/scr/screens/plot.dart';
import 'package:HeartDoc/scr/providers/globals.dart' as globals;

class Graphpoint {
  final int time;
  final double value;

  Graphpoint(this.time, this.value);
}

String contents;
var output;
var input = List(1 * 140).reshape([1, 140]);
List<String> val;
File file;
Future<bool> getUpload() async {
  bool check;
  FilePickerResult result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['txt']);
  if (result != null) {
    file = File(result.files.single.path);
    check = true;
    globals.input = true;
    globals.check = false;
    // await uploadFile(file.readAsBytesSync());
  } else {
    check = false;
    // User canceled the picker
  }
  file.readAsString().then((contents) {
    // print(contents);
    //print(contents.split("  "));
    globals.contents = contents;

    //var onePointOne = double.parse(val[2]);
    //print(onePointOne);
  });
  val = globals.contents.split("  ");
  int len = val.length;
  double l1 = len / 140;
  int l = l1.toInt();
  if (l == 0) globals.check = false;
  //await Future.delayed(Duration(seconds: 1));
  return check;
}

void doit() async {
  await runmodel();
}

Future<void> runmodel() async {
  val = globals.contents.split("  ");
  int len = val.length;
  double l1 = len / 140;
  int l = l1.toInt();
  globals.length = l;
  globals.error = 0;
  input = null;
  output = null;
  int i = globals.length;
  final interpreter = await Interpreter.fromAsset('linear.tflite');
  output = List(i * 140).reshape([i, 140]);
  input = List(i * 140).reshape([i, 140]);
  for (int j = 0; j < i; j++) {
    for (int k = 0; k < 140; k++) {
      double opoint = double.parse(val[k + j * 140]);
      input[j][k] = opoint;
    }
    var input1 = List(1 * 140).reshape([1, 140]);
    input1 = input[j];
    //print(input1);
    var output1 = List(1 * 140).reshape([1, 140]);
    interpreter.run(input1, output1);
    output[j] = output1;
  }
  // getResult();
}

String getResult(int l) {
  //for (int l = 0; l < globals.length; l++) {
  String result;
  double error1 = 0;
  var out = List(1 * 140).reshape([1, 140]);
  out = output[l];
  var inp = List(1 * 140).reshape([1, 140]);
  inp = input[l];
  for (int i = 0; i < 140; i++) {
    double one = inp[i];
    double two = out[0][i];
    double and = (one - two);
    double band;
    band = and.abs();
    error1 = error1 + band;
  }
  error1 = error1 / 140;
  globals.error += error1;
  double threshhold = 0.067;
  double max = 0.12;
  double per = max - threshhold;
  double p = (error1 - threshhold);
  double q = (p / per) * 100;
  int u = q.toInt();
  if (u > globals.max) globals.max = u;
  // print(error1);
  // print(error1);
  // print(error1);
  if (error1 > threshhold) {
    result = "Critical - " + u.toString() + " % ";
  } else
    result = "Normal";
  return result;
}

String getResult1(String email) {
  // int l = globals.length;
  // //for (int l = 0; l < globals.length; l++) {
  String result;
  // double threshhold = 0.067 * l;
  // double max = 0.12 * l;
  // double per = max - threshhold;
  // double p = (globals.error - threshhold);
  // double q = (p / per) * 100;
  // int u = q.toInt();
  // print(error1);
  // print(error1);
  // print(error1);
  if (globals.max > 0) {
    result = "Critical - " + globals.max.toString() + " % ";
  } else
    result = "Normal";
  if (globals.input) updatepatient(email, result);
  globals.max = -1;
  globals.input = false;
  return result;
}

getSeriesData1(int j) {
  final data = [
    for (int i = 0; i < 140; i++) new Graphpoint(i, input[j][i]),
  ];
  // print("Done");
  // print("Done");
  // print("Done");

  // updatepatient(email, result);
  List<charts.Series<Graphpoint, int>> series = [
    charts.Series(
        id: "Value",
        data: data,
        domainFn: (Graphpoint series, _) => series.time,
        measureFn: (Graphpoint series, _) => series.value,
        colorFn: (Graphpoint series, _) =>
            charts.MaterialPalette.blue.shadeDefault)
  ];
  return series;
}

//}
getSeriesData(int j) {
  // if (output != null) {
  var output1 = List(1 * 140).reshape([1, 140]);
  output1 = output[j];
  final data = [
    for (int i = 0; i < 140; i++) new Graphpoint(i, output1[0][i]),
  ];
  print("Done");
  print("Done");
  print("Done");
  String result;
  // result = getResult();
  // updatepatient(email, result);
  List<charts.Series<Graphpoint, int>> series = [
    charts.Series(
        id: "Value",
        data: data,
        domainFn: (Graphpoint series, _) => series.time,
        measureFn: (Graphpoint series, _) => series.value,
        colorFn: (Graphpoint series, _) =>
            charts.MaterialPalette.blue.shadeDefault)
  ];
  //output[j] = null;
  return series;
}
