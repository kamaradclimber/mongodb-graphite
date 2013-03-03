Very simple gem to monitor a mongodb cluster and send data to a graphite server.

Install :

Open the mongodb_graphite file and modify the graphite server variable to your graphite server. For exemple : "mygraphite.mydomain.com:2023"

Add the mongodb_graphite to your crontab, for instance
* * * * mongodb_graphite "graphite.mydomain:2023"

Disclaimer:

this was my first bite of ruby, so I tried to use threading. Please not this program is *not* garanteed to terminate properly.
I don't use it in production anymore.


That's all.

