class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  # post '/pets' do
  #   if params[:pet][:owner_ids]
  #     @pet = Pet.create(name: params[:pet_name], owner_id: params[:pet][:owner_ids].last)
  #   elsif !params[:owner][:name].empty?
  #     @owner = Owner.create(name: params[:owner][:name])
  #     @pet = Pet.create(name: params[:pet_name], owner_id: @owner)
  #     binding.pry
  #   end
  #     #binding.pry
  #   redirect "pets/#{@pet.id}"
  # end

  post '/pets' do
    @pet = Pet.create(params[:pet])
      if !params[:owner][:name].empty?
        @pet.owner = Owner.create(name: params[:owner][:name])
      end
      # if !params[:pet][:owner_ids].empty?
      #   @pet.owner = Owner.find_by(params[:pet][:owner_ids].first.to_i)
      # end
    @pet.save
    #binding.pry
    redirect "pets/#{@pet.id}"
  end
  
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end
end