from django.core.management import BaseCommand

from tickers.data_utilities import load_latest_picker_data


class Command(BaseCommand):

    def handle(self, *args, **options):

        load_latest_picker_data()