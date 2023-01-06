import 'dart:convert';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_app/model/stockmodel.dart';
import 'package:http/http.dart' as http;

class StockAppHome extends StatefulWidget {
  const StockAppHome({super.key});

  @override
  State<StockAppHome> createState() => _StockAppHomeState();
}

class _StockAppHomeState extends State<StockAppHome> {
  Future<List<StockData>> _getStockReports() async {
    final response = await http.get(
      Uri.parse(
          'http://api.marketstack.com/v1/eod?access_key=71055fe318db8751e344ae5b0af7d99a&symbols=AAPL&date_from=2022-10-18&date_to=2023-01-04'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((e) => StockData.fromJson(e)).toList();

      //final json = jsonDecode(response.body) as List;
    } else {
      throw Exception('Failed to Load Stocks Reports');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: ConnectivityWidget(
            builder: ((context, isOnline) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Stock Report App',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      isOnline ? "Connected" : "Offline",
                      style: TextStyle(
                          fontSize: 15,
                          color: isOnline ? Colors.green : Colors.red),
                    ),
                  ],
                )),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder<List<StockData>>(
            future: _getStockReports(),
            builder: ((context, snapshot) {
              List<StockData>? data = snapshot.data;
              stockTile(String symbol, exchange, double open, double close,
                      double high, double low) =>
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 2,
                              blurRadius: 9,
                              offset: const Offset(0, 3))
                        ]),
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Opening Figure : ${open.toString()}', style: TextStyle(fontSize: 15),),
                            Text('Closing Figure : ${close.toString()}', style: TextStyle(fontSize: 15),)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(symbol),
                            Text('Exchange : $exchange'),
                            Text('High : ${high.toString()}'),
                            Text('Low : ${low.toString()}')
                          ],
                        ),
                      ],
                    ),
                  );

              stockReport(index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: stockTile(
                      data![index].symbol,
                      data[index].exchange,
                      data[index].open,
                      data[index].high,
                      data[index].low,
                      data[index].close),
                );
              }

              ListView stockListView(data) {
                return ListView.builder(
                    itemCount: 11,
                    itemBuilder: ((context, index) {
                      return index == 0 ? _searchBar() : stockReport(index - 1);
                    }));
              }

              if (snapshot.hasData) {
                return stockListView(data);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            }),
          ),
        ),
      ),
    );
  }
}

_searchBar() {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: TextField(
      decoration: InputDecoration(hintText: 'Search...'),
      onChanged: searchStock,
    ),
  );
}

void searchStock(String query) {
  // setstate((){

  // });
}
