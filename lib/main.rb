# -*- coding: utf-8 -*-

require 'github_hook'
require 'ostruct'
require 'time'
require 'yaml'

Encoding.default_external = 'UTF-8'

class Blog < Sinatra::Base
  
  # use GithubHook
  
  set :root, File.expand_path('../../', __FILE__)
  set :app_file, __FILE__
  
  get '/*' do |username|
    # TODO:
    # とりあえずリアルタイムで
    # あとでpush hook時にキャッシュするように修正
    articles = []
    Dir.glob "#{settings.root}/var/#{username}/*/*.md" do |file|
      meta, content = File.read(file).split("\n\n", 2)
      article = OpenStruct.new YAML.load(meta)
      article.date = Time.parse article.date.to_s
      article.content = content
      article.slug = File.basename(file, '.md')
      articles << article
    end
    
    articles.sort_by! { |article| [article.date, article.slug] }
    articles.reverse!

    erb :index, :locals => { :username => username, :articles => articles }
  end
  
end
