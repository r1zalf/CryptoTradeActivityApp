import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trade_app/model/trade.dart';
import 'package:trade_app/repo/trade_repo.dart';

class TradeProvider extends ChangeNotifier {
  TradeProvider() {
    fetchRealTimeTrades();
  }

  final TradeRepo _tradeRepo = TradeRepo();

  final List<Trade> _tradeList = [];

  final StreamController<List<Trade>> _tradeStreamController =
      StreamController<List<Trade>>();

  Stream<List<Trade>> get tradeStream => _tradeStreamController.stream;

  fetchRealTimeTrades() {
    final streamTradeRepo = _tradeRepo.getRealTimeTrades();

    streamTradeRepo.listen((event) {

      if (_tradeList.length == 7) {
        _tradeList.remove(_tradeList.first);
      } else {
        var resultDecode = json.decode(event);

        var resultTrade = Trade.fromJson(resultDecode);
        _tradeList.add(resultTrade);

        _tradeStreamController.sink.add(_tradeList);

        notifyListeners();
      }

    }).onError((err) => _tradeStreamController.sink.addError(err));
  }

  @override
  void dispose() {
    super.dispose();
    _tradeStreamController.close();
  }
}
