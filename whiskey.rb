class Whiskey < Sinatra::Base
  get '/' do
    doc = Nokogiri::HTML(open('public/appcast.xml'))
    @version = doc.css('enclosure').first['sparkle:version']
    @version_title = doc.css('item title').first.inner_text

    erb :home
  end

  get '/release-notes/:version' do
    erb :release_notes
  end
end
