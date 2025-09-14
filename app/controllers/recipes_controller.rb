require 'nokogiri'
require 'json'
require 'net/http'
require 'uri'

class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    nokogiri_recipe('https://lianaskitchen.co.uk/butter-bean-and-lentil-soup-in-a-soup-maker/')
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to root_path
    else
      puts @recipe.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :method, :note, :rating, :image)
  end

  def nokogiri_recipe(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 10
    http.read_timeout = 10

    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    html = response.body
    doc = Nokogiri::HTML.parse(html)
    scripts = doc.css('script[type="application/ld+json"]')
    array = []
    scripts.each do |script|
      json_string = script.text
      data = JSON.parse(json_string)
      array << data
    end
    # array of hashes
    array_hashes = array[0]['@graph']
    # array_hashes = array[0]
    @graph = array_hashes.find { |item| item['@type'] == 'Recipe' }
    @recipe_name = @graph['name']
    @ingredients = @graph['recipeIngredient'].join(', ')
    steps = @graph['recipeInstructions'].map { |s| s['text'] }
    @steps = steps.join(' ')
    @image = @graph['image'].first
  end
end
