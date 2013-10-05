Very simple gem to monitor a mongodb cluster and send data to a graphite server.

Usage :

You have to set an environment variable MONGODB_GRAPHITE_DIR (or it will use the config dir in the current directory).
Then write a yml file to contain basic settings:

```yaml
log_dir: log
pid_dir: pids
graphite: graphite.mydomain:3333
interval: 3
instances_file: 'config/instances.rb'
```

Then in config/instances.rb, you can set instances to monitor:

```ruby
instance 'mongoD' do
  host 'onemongo.mydomain'
  port '27021'
  prefix_callback (lambda { |stats|
    process_type = stats['process']
    "production.onemongo.#{process_type}"
  } )
end

instance 'mongoD' do
  host 'anothermongo.mydomain'
  port '27017'
  prefix_callback (lambda { |stats|
    process_type = stats['process']
    "test.anothermongo.#{process_type}"
  } )
end
```

Finally, you can use the gem as a service (start, status, stop)

```
mongodb-graphite start
```
