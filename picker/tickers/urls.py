from django.conf.urls import url

from tickers.views import TestPageView, PickerPageView, TickersLoadedView, SearchTickerDataView, \
    GetRecommendationsView, AddTickerView

app_name='tickers'

urlpatterns = [

    url(r'^$', PickerPageView.as_view(), name='picker_page'),

    url(r'^test/$', TestPageView.as_view(), name='test_page'),

    url(r'^tickerlist/$', TickersLoadedView.as_view(), name='tickers_loaded'),

    url(r'^tickerdata/$', SearchTickerDataView.as_view(), name='search_ticker_data'),

    url(r'^recommendations/$', GetRecommendationsView.as_view(), name='get_recommendations'),

    url(r'^addticker/$', AddTickerView.as_view(), name='add_ticker'),

]
