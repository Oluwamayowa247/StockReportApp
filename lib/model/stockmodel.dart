class StockData {
  double open;
  double high;
  double low;
  double close;
  String symbol;
  String exchange;

  StockData({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.symbol,
    required this.exchange,
  });

  factory StockData.fromJson(Map<String, dynamic> json) => StockData(
        open: json["open"].toDouble(),
        high: json["high"].toDouble(),
        low: json["low"].toDouble(),
        close: json["close"].toDouble(),
        exchange: json["exchange"],
        symbol: json['symbol'],
      );
}
