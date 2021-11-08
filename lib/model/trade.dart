class Trade {
  late String type;
  late String symbolId;
  late int sequence;
  late String timeExchange;
  late String timeCoinapi;
  late String uuid;
  late double price;
  late double size;
  late String takerSide;

  Trade(
      {required this.type,
      required this.symbolId,
      required this.sequence,
      required this.timeExchange,
      required this.timeCoinapi,
      required this.uuid,
      required this.price,
      required this.size,
      required this.takerSide});

  Trade.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    symbolId = json['symbol_id'];
    sequence = (json['sequence'] as num).toInt();
    timeExchange = json['time_exchange'];
    timeCoinapi = json['time_coinapi'];
    uuid = json['uuid'];
    price = (json['price'] as num).toDouble();
    size = (json['size'] as num).toDouble();
    takerSide = json['taker_side'];
  }
}
