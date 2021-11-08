import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trade_app/model/trade.dart';
import 'package:trade_app/provider/trade_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B232A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recent Activity",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Consumer<TradeProvider>(builder: (_, value, __) {
                  return StreamBuilder<List<Trade>>(
                      stream: value.tradeStream,
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, i) =>
                                  PerItemTrade(snapshot.data![i]));
                        } else {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          );
                        }
                      });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PerItemTrade extends StatelessWidget {
  final Trade trade;
  const PerItemTrade(this.trade, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: trade.takerSide == "BUY"
                    ? const Color(0xFF5ED5A8).withOpacity(0.1)
                    : const Color(0xFFDD4B4B).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(trade.takerSide[0], style: TextStyle(fontWeight: FontWeight.bold, color: trade.takerSide == "BUY"
                    ?const Color(0xFF5ED5A8)
                    :const Color(0xFFDD4B4B),),), 
              ),
            ),
            Expanded(
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "${trade.symbolId.split("_")[2]}/${trade.symbolId.split("_")[3]}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        trade.timeExchange,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF777777),
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF777777)
                      ),
                    ),
                    Expanded(
                      child: Text(
                        trade.size.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5ED5A8),
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Price",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF777777),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        trade.price.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFA7AFB7),
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF777777),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        trade.takerSide,
                        style: TextStyle(
                          fontSize: 14,
                          color: trade.takerSide == "BUY"
                              ?const Color(0xFF5ED5A8)
                              :const Color(0xFFDD4B4B),
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                )
              ]),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 12),
          height: 0.5,
          width: double.infinity,
          color:const  Color(0xFFA7AFB7).withOpacity(0.3),
        ),
      ],
    );
  }
}
