require 'nokogiri'
require 'json'
require 'open-uri'

class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    nokogiri_recipe
  end

  def create
  end

  private

  def nokogiri_recipe
    url = 'https://lianaskitchen.co.uk/easy-chicken-soup-recipe/'
    html = URI.open(url)
    doc = Nokogiri::HTML.parse(html)
    @scripts = doc.css('script[type="application/ld+json"]')
  end
end
