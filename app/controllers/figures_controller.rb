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
#    @figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
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
