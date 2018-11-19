class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  post '/figures' do
  #binding.pry
    #@figure = Figure.create(params[:figure])
    @figure = Figure.create(:name => params[:figure][:name])
    #if !params["landmark"]["name"].include?(landmark)
    #@figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    #end
    #if !params["title"]["name"].empty?
      #@figure.titles << Title.create(name: params["title"]["name"])
    #end
    if !params[:figure].keys.include?("landmark_id")
      params[:figure]["landmark_id"] = []
    end
    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])
    if !params["landmark"]["name"].empty?
    @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    end
    #@figure.landmarks = Landmark.find_or_create_by(:name => params[:landmarks])
    #@figure.titles = Landmark.find_or_create_by(:name => params[:titles])
    @figure.save
    redirect to "figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    if !params[:figure].keys.include?("landmark_ids")
      params[:figure][:landmark_ids] = []
    end
    @figure = Figure.find(params[:id])
    @figure = Figure.update(params[:figure])
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    if !params[:landmark][:name].empty?
     @figure.title << Title.create(name: params[:title][:name])
    end
    redirect to "figures/#{@figure.id}"
  end


end
