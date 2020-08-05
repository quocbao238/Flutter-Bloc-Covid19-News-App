import 'package:meta/meta.dart';
import 'dart:convert';

//https://covidtracking.com/api/v1/us/daily.json

List<TotalCovidRes> totalCovidResFromJson(String str) => List<TotalCovidRes>.from(json.decode(str).map((x) => TotalCovidRes.fromJson(x)));

String totalCovidResToJson(List<TotalCovidRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalCovidRes {
    TotalCovidRes({
        @required this.date,
        @required this.states,
        @required this.positive,
        @required this.negative,
        @required this.pending,
        @required this.hospitalizedCurrently,
        @required this.hospitalizedCumulative,
        @required this.inIcuCurrently,
        @required this.inIcuCumulative,
        @required this.onVentilatorCurrently,
        @required this.onVentilatorCumulative,
        @required this.recovered,
        @required this.dateChecked,
        @required this.death,
        @required this.hospitalized,
        @required this.lastModified,
        @required this.total,
        @required this.totalTestResults,
        @required this.posNeg,
        @required this.deathIncrease,
        @required this.hospitalizedIncrease,
        @required this.negativeIncrease,
        @required this.positiveIncrease,
        @required this.totalTestResultsIncrease,
        @required this.hash,
    });

    final int date;
    final int states;
    final int positive;
    final int negative;
    final int pending;
    final int hospitalizedCurrently;
    final int hospitalizedCumulative;
    final int inIcuCurrently;
    final int inIcuCumulative;
    final int onVentilatorCurrently;
    final int onVentilatorCumulative;
    final int recovered;
    final DateTime dateChecked;
    final int death;
    final int hospitalized;
    final DateTime lastModified;
    final int total;
    final int totalTestResults;
    final int posNeg;
    final int deathIncrease;
    final int hospitalizedIncrease;
    final int negativeIncrease;
    final int positiveIncrease;
    final int totalTestResultsIncrease;
    final String hash;

    factory TotalCovidRes.fromJson(Map<String, dynamic> json) => TotalCovidRes(
        date: json["date"] == null ? null : json["date"],
        states: json["states"] == null ? null : json["states"],
        positive: json["positive"] == null ? null : json["positive"],
        negative: json["negative"] == null ? null : json["negative"],
        pending: json["pending"] == null ? null : json["pending"],
        hospitalizedCurrently: json["hospitalizedCurrently"] == null ? null : json["hospitalizedCurrently"],
        hospitalizedCumulative: json["hospitalizedCumulative"] == null ? null : json["hospitalizedCumulative"],
        inIcuCurrently: json["inIcuCurrently"] == null ? null : json["inIcuCurrently"],
        inIcuCumulative: json["inIcuCumulative"] == null ? null : json["inIcuCumulative"],
        onVentilatorCurrently: json["onVentilatorCurrently"] == null ? null : json["onVentilatorCurrently"],
        onVentilatorCumulative: json["onVentilatorCumulative"] == null ? null : json["onVentilatorCumulative"],
        recovered: json["recovered"] == null ? null : json["recovered"],
        dateChecked: json["dateChecked"] == null ? null : DateTime.parse(json["dateChecked"]),
        death: json["death"] == null ? null : json["death"],
        hospitalized: json["hospitalized"] == null ? null : json["hospitalized"],
        lastModified: json["lastModified"] == null ? null : DateTime.parse(json["lastModified"]),
        total: json["total"] == null ? null : json["total"],
        totalTestResults: json["totalTestResults"] == null ? null : json["totalTestResults"],
        posNeg: json["posNeg"] == null ? null : json["posNeg"],
        deathIncrease: json["deathIncrease"] == null ? null : json["deathIncrease"],
        hospitalizedIncrease: json["hospitalizedIncrease"] == null ? null : json["hospitalizedIncrease"],
        negativeIncrease: json["negativeIncrease"] == null ? null : json["negativeIncrease"],
        positiveIncrease: json["positiveIncrease"] == null ? null : json["positiveIncrease"],
        totalTestResultsIncrease: json["totalTestResultsIncrease"] == null ? null : json["totalTestResultsIncrease"],
        hash: json["hash"] == null ? null : json["hash"],
    );

    Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "states": states == null ? null : states,
        "positive": positive == null ? null : positive,
        "negative": negative == null ? null : negative,
        "pending": pending == null ? null : pending,
        "hospitalizedCurrently": hospitalizedCurrently == null ? null : hospitalizedCurrently,
        "hospitalizedCumulative": hospitalizedCumulative == null ? null : hospitalizedCumulative,
        "inIcuCurrently": inIcuCurrently == null ? null : inIcuCurrently,
        "inIcuCumulative": inIcuCumulative == null ? null : inIcuCumulative,
        "onVentilatorCurrently": onVentilatorCurrently == null ? null : onVentilatorCurrently,
        "onVentilatorCumulative": onVentilatorCumulative == null ? null : onVentilatorCumulative,
        "recovered": recovered == null ? null : recovered,
        "dateChecked": dateChecked == null ? null : dateChecked.toIso8601String(),
        "death": death == null ? null : death,
        "hospitalized": hospitalized == null ? null : hospitalized,
        "lastModified": lastModified == null ? null : lastModified.toIso8601String(),
        "total": total == null ? null : total,
        "totalTestResults": totalTestResults == null ? null : totalTestResults,
        "posNeg": posNeg == null ? null : posNeg,
        "deathIncrease": deathIncrease == null ? null : deathIncrease,
        "hospitalizedIncrease": hospitalizedIncrease == null ? null : hospitalizedIncrease,
        "negativeIncrease": negativeIncrease == null ? null : negativeIncrease,
        "positiveIncrease": positiveIncrease == null ? null : positiveIncrease,
        "totalTestResultsIncrease": totalTestResultsIncrease == null ? null : totalTestResultsIncrease,
        "hash": hash == null ? null : hash,
    };
}
