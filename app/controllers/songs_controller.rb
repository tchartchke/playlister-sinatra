class SongsController < ApplicationController
  get '/songs' do
    erb :'songs/index'
  end

  get '/songs/new' do
    erb :'songs/new'
  end

  post '/songs' do
    new_song = Song.create(params[:song])
    artist = Artist.find_by_slug(params[:artist][:name].downcase.gsub(' ', '-'))
    artist ||= Artist.create(params[:artist])
    new_song.artist = artist
    params[:genres].each do |genre|
      SongGenre.create(song_id: new_song.id, genre_id: genre)
    end
    new_song.save
    flash[:notice] = "Successfully created song."
    redirect "/songs/#{new_song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  patch '/songs/:slug' do
    song = Song.find_by_slug(params[:slug])
    artist = Artist.find_by(params[:artist])
    artist ||= Artist.create(params[:artist])
    song.artist = artist
    song.genre_ids = params[:genres]
    song.save
    flash[:notice] = "Successfully updated song."
    redirect "/songs/#{song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end
end
