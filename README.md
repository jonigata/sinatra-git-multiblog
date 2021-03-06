## sinatra git blog

This is a simple blog host written with [Sinatra](https://github.com/sinatra/sinatra).

Markdown articles are placed in `/articles` for publication.


### To run

    rackup -p 4567

or, say:

    rackup -E production -D -s thin

### Notes

A git post-receive hook is included that will update the published articles
on the server when article updates have been pushed (providing
`RACK_ENV == 'production'`). The hook responds to a `POST` to `/update`.

So, a simple hook script could be:

    #!/usr/bin/env ruby
    require 'rest-client'
    RestClient.post 'http://example.com/update', ''

### License

See LICENSE.
