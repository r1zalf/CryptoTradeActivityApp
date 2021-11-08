import 'dart:convert';

import 'package:web_socket_channel/io.dart';

class TradeRepo {
  final channel = IOWebSocketChannel.connect("ws://ws-sandbox.coinapi.io/v1/");

  Stream<dynamic> getRealTimeTrades() {
    var hello = json.encode({
      "type": "hello",
      "apikey": "48783C42-6973-4AE4-8F50-303A5CED8BF9",
      "heartbeat": false,
      "subscribe_data_type": ["trade"],
      "subscribe_filter_symbol_id": [
        "COINBASE_",
      ]
    });

    channel.sink.add(hello);

    return channel.stream;
  }
}
