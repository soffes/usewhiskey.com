require 'json'

class Whiskey < Sinatra::Base
  get '/' do
    @version_title = doc.css('item title').first.inner_text
    erb :home
  end

  get '/latest' do
    version = doc.css('enclosure').first['sparkle:version']
    redirect "https://whiskey-app.s3.amazonaws.com/builds/Whiskey-#{version}.zip"
  end

  get '/latest.json' do
    item = doc.css('item').first
    enclosure = item.css('enclosure').first

    headers 'Content-Type' => 'application/json'
    {
      version: enclosure['sparkle:version'].to_i,
      short_version: item.css('title').text.sub('Version ', ''),
      download_url: enclosure['url'],
      release_notes_url: item.xpath('.//sparkle:releaseNotesLink').first.inner_text
    }.to_json
  end

  get %r{/release-notes(?:/(?<version>\d+))?} do
    @is_sparkle = !request.user_agent.match(/\(KHTML, like Gecko\)$/).nil?
    @version = (params[:version] || 0).to_i
    @versions = doc.css('item')
    erb :release_notes
  end

  private

  def doc
    @doc ||= Nokogiri::XML(open('public/appcast.xml'))
  end
end
