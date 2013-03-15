# -*- coding: utf-8 -*-

require 'ostruct'
require 'time'
require 'yaml'

Encoding.default_external = 'UTF-8'

class Blog < Sinatra::Base
  
  set :root, File.expand_path('../../', __FILE__)

  # update repository
  get %r{^/([-a-zA-Z_]+)/update$} do |username|
    git = "git --git-dir=#{settings.root}/var/users/#{username}/.git"
    `#{git} pull 2>&1`
  end

  # user top page
  get '/*' do |username|
    # TODO:
    # とりあえずリアルタイムで
    # あとでupdate時にキャッシュするように修正
    articles = []
    Dir.glob "#{settings.root}/var/users/#{username}/*/*.md" do |file|
      next if file =~ /\.comments\.md/
      meta, content = File.read(file).split("\n\n", 2)
      article = OpenStruct.new YAML.load(meta)
      article.date = Time.parse article.date.to_s
      article.content = content
      article.comments = open(file.sub(/\.md$/, ".comments.md")).read rescue nil
      article.slug = File.basename(file, '.md')
      articles << article
    end
    
    articles.sort_by! { |article| [article.date, article.slug] }
    articles.reverse!

    erb :index, :locals => { :username => username, :articles => articles }
  end

  # user post page

  # comment
  post %r{^/([-a-zA-Z_]+)/post/(\d{4})-(\d{2})-(\d{2})$} do |username, year, month, day|
    repdir = "#{settings.root}/var/users/#{username}"
    filename = "#{repdir}/#{year}-#{month}/#{year}-#{month}-#{day}.comments.md"
    open(filename, "a") do |file|
      file.write(params[:comment] + "\n")
    end
    git = "git --git-dir=#{repdir}/.git --work-tree=#{repdir}"
    `#{git} add #{year}-#{month}/#{year}-#{month}-#{day}.comments.md 2>&1`
    `#{git} commit -a -m "add comment" 2>&1`
    `#{git} push 2>&1`
    #'OK'
    redirect "/#{username}"
  end
  
end
