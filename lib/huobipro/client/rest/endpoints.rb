
module Huobipro
  module Client
    class REST
      ENDPOINTS = {
        # Public API Endpoints
        # 独有的
        currencys: "/v1/common/currencys",
        symbols: "/v1/common/symbols",
        trade:             '/market/trade',

        # 共有的
        depth:              '/market/depth',
        history_trade:            '/market/history/trade',
        day_trade: '/market/detail',
        klines:              '/market/history/kline',

        merged:     '/market/detail/merged',
        market_trade:          '/market/depth',
        # agg_trades:        'v1/aggTrades',
        # klines:            'v1/klines',
        # twenty_four_hour:  'v1/ticker/24hr',
        # price:             'v3/ticker/price',
        # book_ticker:       'v3/ticker/bookTicker',

        # # Account API Endpoints
        # order:            'v3/order',
        # test_order:       'v3/order/test',
        # open_orders:      'v3/openOrders',
        # all_orders:       'v3/allOrders',
        # account:          'v3/account',
        # my_trades:        'v3/myTrades',
        # user_data_stream: 'v1/userDataStream',

        # # Withdraw API Endpoints
        # withdraw:         'v3/withdraw.html',
        # deposit_history:  'v3/depositHistory.html',
        # withdraw_history: 'v3/withdrawHistory.html',
        # deposit_address:  'v3/depositAddress.html',
        # account_status:   'v3/accountStatus.html',
        # system_status:    'v3/systemStatus.html',
        # withdraw_fee:     'v3/withdrawFee.html'
      }.freeze
    end
  end
end
