# Picker
-------------

Picker is a toy stock-picker application, though it is not intended to provide actual stock picking advice. Let me say that again. **Picker is not intended to provide financial advice!** Picker is intended to be a demonstration of various software development technologies, and a place for me to experiment with new ones.

See it live here (works best in Chrome): [http://ec2-13-58-246-90.us-east-2.compute.amazonaws.com/](http://ec2-13-58-246-90.us-east-2.compute.amazonaws.com/)

Picker uses the [pandas_datareader](https://pandas-datareader.readthedocs.io/en/latest/) and [fix_yahoo_finance](https://github.com/ranaroussi/fix-yahoo-finance) (also see [this SO answer](https://stackoverflow.com/a/44319962/2551686)) to download price data for financial instruments (by ticker), saves the data to [Elasticsearch](http://www.elasticsearch.org/), does some analysis on the data and saves the results back to Elasticsearch. The UI makes AJAX calls to the server application to access the data. The charts are built with the [Flot](http://www.flotcharts.org/) libary for [jQuery](http://jquery.com/), based on some techniques I found in this online book: [Data Visualization with JavaScript](http://jsdatav.is/intro.html).

The charts currently provided are as follows:

* Adjusted Close for the security selected (by ticker symbol) and an index. [SPY](http://finance.yahoo.com/q?s=SPY) is currently used for the index.
* Scaled Adjusted Close (the security's adjusted closing price divided by the index's adjusted closing price), plotted against a 20-month (86-week) moving average of Scaled Adjusted Close (SACMA)

Also shown are a list of "Buy" and "Sell" picks, based on a simple algorithm. If SAC is less than SACMA, but has been greater than SACMA in the last year, the ticker is marked as a "Buy" pick. If SAC is greater than SACMA, the ticker is marked as a "Sell" pick.

Deployment is handled with [Terraform](https://www.terraform.io/) and [Ansible](https://www.ansible.com/).

More functionality will be added to the project as I have time. Feel free to clone/fork the repo yourself!

## TODOS:

- Clean up the data processing code (it's currently a bit of a mess, and that's my fault and I'm sorry).
- Ansychronous data load/update task processing with [Celery](http://www.celeryproject.org/) and [Redis](https://redis.io/).
- Rebuild the front-end with [Ember](https://emberjs.com/).
- Write compelling blog posts about all the various parts of the app.