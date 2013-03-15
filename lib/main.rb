# -*- coding: utf-8 -*-

require 'ostruct'
require 'time'
require 'yaml'

Encoding.default_external = 'UTF-8'

class Blog < Sinatra::Base
  
  set :root, File.expand_path('../../', __FILE__)

  # update repository
  get %r{^/([-a-zA-Z_]+)/update$} do |username|
    git = "git --git-dir=#{settings.root}/../var/#{username}/.git"
    `#{git} pull 2>&1`
  end

  # user top page
  get '/*' do |username|
    # TODO:
    # とりあえずリアルタイムで
    # あとでupdate時にキャッシュするように修正
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

  # user post page

  # 
  
end
