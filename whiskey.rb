class Whiskey < Sinatra::Base
  get '/' do
    @version_title = doc.css('item title').first.inner_text
    erb :home
  end

  get '/latest' do
    version = doc.css('enclosure').first['sparkle:version']
    redirect "https://whiskey-app.s3.amazonaws.com/builds/Whiskey-#{version}.zip"
  end

  get %r{/release-notes(?:/(?<version>\d+))?} do
    @version = (params[:version] || 0).to_i
    @versions = doc.css('item')
    erb :release_notes
  end

  private

  def doc
    @doc ||= Nokogiri::XML(open('public/appcast.xml'))
  end
end
