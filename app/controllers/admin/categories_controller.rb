class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_BASIC_AUTH_USER'], password: ENV['HTTP_BASIC_AUTH_PASSWORD']


  def index
    
    # n+1 query problem
    # @category_items = Product.group(:category_id).count.map { |k,v| {name: Category.find(k).name, count: v} } 
    # { 1: { name: Apparel, count: 6 } ... }

    # THE JOIN METHOD WORKS ONLY FOR INNER JOIN
    # @category_items = Category.joins(:products).select('categories.*, count(products.id) as product_count').group('categories.id')

    #FOR OUTER JOINS, USE A JOIN
    @category_items = Category.joins('LEFT OUTER JOIN products ON products.category_id = categories.id').select('categories.*, count(products.id) as product_count').group('categories.id').sort { |a, b| b.product_count <=> a.product_count }

  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
  
    if @category.save
      puts @category.name
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end



  private
  def category_params
    params.require(:category).permit(
      :name
    )
  end


end
