# frozen_string_literal: true

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = Integer(ENV.fetch('RAILS_MAX_THREADS', 5))
min_threads_count = Integer(ENV.fetch('RAILS_MIN_THREADS') { max_threads_count })
threads min_threads_count, max_threads_count

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch('RAILS_ENV', 'production')

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch('PIDFILE', 'tmp/pids/server.pid')

# Bind the server to 'url'. 'tcp://', 'unix://' and 'ssl://' are the only
# accepted protocols.
#
# The default is 'tcp://0.0.0.0:9292'.
#
## [DN] Force binding on port 3000
bind 'tcp://0.0.0.0:3000'

# Verifies that all workers have checked in to the master process within
# the given timeout. If not the worker process will be restarted. This is
# not a request timeout, it is to protect against a hung or dead process.
# Setting this value will not protect against slow requests.
#
# The minimum value is 6 seconds, the default value is 60 seconds.
worker_timeout 60

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
## [DN] It should be # of CPUs - 1 (but at least 2)
workers Integer(ENV.fetch('WEB_CONCURRENCY', 5))

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
preload_app!

## [DN] Ensure the connection is established with the DB
on_worker_boot do
  ActiveRecord::Base.establish_connection
end
