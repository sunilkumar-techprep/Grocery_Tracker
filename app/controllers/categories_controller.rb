class CategoriesController < ApplicationController
  def index
    matching_categories = Category.all

    @list_of_categories = matching_categories.order({ :created_at => :desc })

    render({ :template => "categories/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_categories = Category.where({ :id => the_id })

    @the_category = matching_categories.at(0)

    render({ :template => "categories/show.html.erb" })
  end

  def create
    the_category = Category.new
    the_category.name = params.fetch("query_name")

    if the_category.valid?
      the_category.save
      redirect_to("/categories", { :notice => "Category created successfully." })
    else
      redirect_to("/categories", { :alert => the_category.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_category = Category.where({ :id => the_id }).at(0)

    the_category.name = params.fetch("query_name")

    if the_category.valid?
      the_category.save
      redirect_to("/categories/#{the_category.id}", { :notice => "Category updated successfully."} )
    else
      redirect_to("/categories/#{the_category.id}", { :alert => the_category.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_category = Category.where({ :id => the_id }).at(0)

    the_category.destroy

    redirect_to("/categories", { :notice => "Category deleted successfully."} )
  end
  
    def display
       #Get the selected category from the query parameters
      @selected_category = params[:query_category].downcase
    
      # Get the user input for item names and split it into an array
      user_input = params[:query_name]
      item_names = user_input.split(",").map { |name| name.gsub(/\W+/, '').strip.downcase }
    
      # Find all items that match the selected category and the user input
      @list_of_items = Item.where(category: @selected_category, name: item_names)
    
      if @list_of_items.empty?
       render({ template: "items/no_matching_items.html.erb" })
      else
        render({ template: "items/displayitem.html.erb" })
      end
    end

      #def category
        #input_name = params.fetch("query_name").gsub(/\d/, "").strip.downcase
        #input_category = params.fetch("query_category").downcase
        
        #matching_items = Item.where("LOWER(name) LIKE ?", "%#{input_name}%").where("category = ?", input_category)
      
        #@list_of_items = matching_items
        #if @list_of_items.empty?
          #render({ template: "items/no_matching_items.html.erb" })
        #else
          #render({ :template => "items/finditem.html.erb" })
        #end
      #end

      #def category
        #input_name = params.fetch("query_name").gsub(/\d/, "").strip.downcase
        #input_category = params.fetch("query_category").downcase
      
        #input_names = input_name.split(",").map(&:strip) # Split input names by commas and remove leading/trailing spaces
        #matching_items = Item.where("LOWER(name) IN (?)", input_names).where("category = ?", input_category) # Use IN clause to match multiple names
      
        #@list_of_items = matching_items
        #@non_matching_items = input_names - matching_items.pluck(:name) # Find non-matching items
        #if @list_of_items.empty?
          #render({ template: "items/no_matching_items.html.erb" })
        #else
          #render({ template: "items/displayitem.html.erb" })
        #end
      #end
      
      #def category
        #input_name = params.fetch("query_name").gsub(/\d/, "").strip.downcase
        #@input_category = params.fetch("query_category").downcase
        #@input_category = params.fetch("query_category").downcase.strip

        #input_names = input_name.split(",").map(&:strip)
        #matching_items = Item.where("LOWER(name) LIKE ?", "%#{input_name}%").where("LOWER(category) = ?", @input_category)
        
        #@list_of_items = matching_items
        #@non_matching_items = input_names - matching_items.pluck(:name) 
        #if @list_of_items.empty?
          #render({ template: "items/no_matching_items.html.erb" })
        #else
          #render({ :template => "items/displayitem.html.erb" })
        #end
      #end
      #First, you are using the "input_name" parameter to perform the search for items, but this parameter is not split correctly to handle multiple input names separated by commas. Instead of using "input_name.split(','), you should use "input_names" which is correctly split and mapped to remove leading and trailing whitespaces.

#Second, you are using "where" clauses to filter the items based on the "name" and "category" fields separately, which might result in an empty result set when both "name" and "category" do not match simultaneously. You should use a single "where" clause with "AND" condition to filter items based on both "name" and "category" fields together.

#Here's a modified version of the code that might resolve the issue:--->


 def search_category_item
  render({ :template => "items/category.html.erb" })
 end

 def category
  input_name = params.fetch("query_name").gsub(/\d/, "").strip.downcase
  @input_category = params.fetch("query_category").downcase.strip

  input_names = input_name.split(",").map(&:strip)
  matching_items = Item.where("LOWER(name) IN (?) AND LOWER(category) = ?", input_names, @input_category)

  @list_of_items = matching_items
  @non_matching_items = input_names - matching_items.pluck(:name) 

  render({ :template => "items/displayitem.html.erb" })
  
end



    end
 
