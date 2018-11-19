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
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/show'
  end

  post '/figures' do
  #binding.pry
    @figure = Figure.create(:name => params[:figure][:name])
    #if !params["landmark"]["name"].include?(landmark)
    #@figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    #end
    #if !params["title"]["name"].empty?
      #@figure.titles << Title.create(name: params["title"]["name"])
    #end
  #  if !params[:figure].keys.include?("landmark_id")
    #  params[:figure]["landmark_id"] = []
  #  end
  #  @figure = Figure.find(params[:id])
  #  @figure.update(params["figure"])
  #  if !params["landmark"]["name"].empty?
  #  @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
  #  end
    #@figure.landmarks = Landmark.find_or_create_by(:name => params[:landmarks])
    #@figure.titles = Landmark.find_or_create_by(:name => params[:titles])
  #  @figure.save
  #  redirect to "figures/#{@figure.id}"
  end

    #@title = params[:title]
    #@title_ids = params[:figure][:title_ids]
    #@landmark = params[:landmark]
    #@landmark_ids = params[:figure][:landmark_ids]
  

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    #if !params[:figure].keys.include?("landmark_ids")
    #  params[:figure][:landmark_ids] = []
    #end
    #@figure = Figure.find(params[:id])
    #@figure = Figure.update(params[:figure])
    #if !params[:landmark][:name].empty?
    #  @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    #end
    #if !params[:landmark][:name].empty?
    # @figure.title << Title.create(name: params[:title][:name])
    #end
    #redirect to "figures/#{@figure.id}"
  #end
     @title = params[:title]
     @title_ids = params[:figure][:title_ids]
     @landmark = params[:landmark]
     @landmark_ids = params[:figure][:landmark_ids]

     @figure = Figure.find(params[:id])
     @figure.name = params[:figure][:name]
     if @title_ids
       @figure.titles.clear
       @title_ids.each do |id|
         t = Title.find(id)
         @figure.titles << t
       end
     end
     if !@title[:name].empty?
       t = Title.create(:name => @title[:name])
       @figure.titles << t
     end
     if @landmark_ids
       @figure.landmarks.clear
       @landmark_ids.each do |id|
         l = Landmark.find(id)
         @figure.landmarks << l
       end
     end
     if !@landmark[:name].empty?
       l = Landmark.create(:name => @landmark[:name])
       @figure.landmarks << l
     end
     @figure.save
     redirect to "/figures/#{@figure.id}"
   end

end
