from elasticsearch import Elasticsearch

from django.conf import settings
from django.views.generic import View, TemplateView

from rest_framework.views import APIView
from rest_framework.response import Response

from tickers.data_utilities import get_tickerlist, search_ticker_data, get_recommendations, add_ticker


class TestPageView(TemplateView):

    template_name = 'tickers/test_page.html'


class PickerPageView(TemplateView):

    template_name = 'tickers/picker.html'


class ESClientView(View):

    es_client = None

    def __init__(self):
        super(ESClientView, self).__init__()
        self.es_client = Elasticsearch(hosts=[settings.ES_HOST])


class SearchTickerDataView(APIView, ESClientView):

    def post(self, request, format=None):
        return Response(search_ticker_data(es_client=self.es_client,
                                           ticker=request.data['ticker'].lower(),
                                           es_request_body=request.data['es_request']))


class TickersLoadedView(APIView, ESClientView):

    def get(self, request, format=None):
        return Response(get_tickerlist(es_client=self.es_client))


class GetRecommendationsView(APIView, ESClientView):

    def get(self, request, format=None):
        return Response(get_recommendations(es_client=self.es_client))


class AddTickerView(APIView,ESClientView):

    def post(self, request, format=None):
        return Response(add_ticker(es_client=self.es_client,
                                   ticker=request.data['ticker']))
