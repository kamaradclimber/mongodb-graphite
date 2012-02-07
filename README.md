Very simple gem to monitor a mongodb cluster and send data to a graphite server.

Install :

Open the mongodb_graphite file and modify the graphite server variable to your graphite server. For exemple : "mygraphite.mydomain.com:2023"

Add the mongodb_graphite to your crontab, for instance
* * * * mongodb_graphite "graphite.mydomain:2023"


That's all.

