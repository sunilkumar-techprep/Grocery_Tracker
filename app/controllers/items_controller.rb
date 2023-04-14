class ItemsController < ApplicationController

  class ItemsController < ApplicationController
    def create
      @item = Item.new(item_params)
      if Item.same_name_with_different_quantity_or_description(@item)
        flash[:error] = "An item with the same name already exists with a different quantity or description"
        render :new
      elsif @item.save
        flash[:success] = "Item was successfully created"
        redirect_to @item
      else
        render :new
      end
    end
  
    private
  
    def item_params
      params.require(:item).permit(:name, :purchased_date, :expiration_date, :quantity, :description, :location, :categories)
    end
  end
  



  def index
    matching_items = Item.all

    @list_of_items = matching_items.order({ :created_at => :desc })

    render({ :template => "items/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    
    matching_items = Item.where({ :id => the_id })

    @the_item = matching_items.at(0)

    render({ :template => "items/show.html.erb" })
  end

  def create
    the_item = Item.new
    the_item.name = params.fetch("query_name")
    the_item.purchase_date = params.fetch("query_purchase_date")
    the_item.expiration_date = params.fetch("query_expiration_date")
    the_item.quantity = params.fetch("query_quantity")
    the_item.description = params.fetch("query_description")
    the_item.image = params.fetch("query_image")
    the_item.location = params.fetch("query_location")
    the_item.category = params.fetch("query_category")
    #@user.image = params.fetch(:image)
    if the_item.valid?
      the_item.save
      redirect_to("/items", { :notice => "Item created successfully." })
    else
      redirect_to("/items", { :alert => the_item.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_item = Item.where({ :id => the_id }).at(0)

    the_item.name = params.fetch("query_name")
    the_item.purchase_date = params.fetch("query_purchase_date")
    the_item.expiration_date = params.fetch("query_expiration_date")
    the_item.quantity = params.fetch("query_quantity")
    the_item.description = params.fetch("query_description")
    the_item.image = params.fetch("query_image")
    the_item.location = params.fetch("query_location")
    the_item.category = params.fetch("query_category")

    if the_item.valid?
      the_item.save
      redirect_to("/items/#{the_item.id}", { :notice => "Item updated successfully."} )
    else
      redirect_to("/items/#{the_item.id}", { :alert => the_item.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_item = Item.where({ :id => the_id }).at(0)

    the_item.destroy

    redirect_to("/items", { :notice => "Item deleted successfully."} )
  end
  def homepage
  
    render({ :template => "items/homepage.html.erb" })
  end
  
    

    


def cate_item
  @selected_category = params[:query_category]
  @items_in_category = Item.where(category: @selected_category)

  if @items_in_category.empty?
    render({ template: "items/no_items_in_category.html.erb" })
  else
    render({ template: "items/items_in_category.html.erb" })
  end
end

def search
  render({ template: "items/search.html.erb" })
end


def item_by_name
 render({ template: "items/item_by_name.html.erb" })
end
def change_item

  the_id = params.fetch("path_id")
    the_item = Item.where({ :id => the_id }).at(0)

    @the_item.name = the_item.name
    the_item.purchase_date = the_item.purchase_date
    the_item.expiration_date = the_item.expiration_date
    the_item.quantity = the_item.quantity
    the_item.description = the_item.description
    the_item.image =the_item.image
    the_item.location = the_item.location
    the_item.category = the_item.category

  render({ template: "items/change_item.html.erb" })

  
end 

#def find_item
  #input_string = params.fetch("query_name").downcase
  #input_array = input_string.split(",").map { |s| s.gsub(/[^a-zA-Z\s]/, "").gsub(/\s+/, "") }
  #input_array = input_string.split(",").map { |s| s.strip.gsub(/[^a-zA-Z\s]/, "").gsub(/\s+/, "") }

  #matching_items = Item.all

  #input_array.each do |word|
    #matching_items = matching_items.where("LOWER(name) LIKE ?", "%#{word}%")
    #matching_items = matching_items.where("LOWER(name) ILIKE ?", "%#{word}%")
  #end
  #@list_of_items = matching_items
  #render({ :template => "items/finditem.html.erb" })
#end

def find_item
  input_string = params.fetch("query_name").gsub(/\d/, "").split(",").map(&:strip).map(&:downcase)

  matching_items = []
  input_string.each do |word|
    matching_items.concat(Item.where("LOWER(name) LIKE ?", "%#{word}%"))
  end

  @list_of_items = matching_items
  render({ :template => "items/finditem.html.erb" })
end



def allitems
  matching_items = Item.all

  @list_of_items = matching_items.order({ :created_at => :desc })

  
   render({ :template => "items/allitem.html.erb" })
end
def category_item
  input_name = params.fetch("query_name").gsub(/\d/, "").strip.downcase
  input_category = params.fetch("query_category").strip
  
  matching_items = Item.where("LOWER(name) LIKE ?", "%#{input_name}%")
                        .where("category = ?", input_category)
  @list_of_items = matching_items
  if @list_of_items.empty?
    render({ template: "items/no_items_in_category.html.erb" })
  else
  
  render({ :template => "items/finditem.html.erb" })
end
 
end
def search_item
  input_string = params.fetch("query_name").gsub(/\d/, "").split(",").map(&:strip).map(&:downcase)

  matching_items = []
  input_string.each do |word|
    matching_items.concat(Item.where("LOWER(name) LIKE ?", "%#{word}%"))
  end

  @list_of_items = matching_items
  @non_matching_items = input_string - matching_items.pluck(:name) 
  render({ :template => "items/items.html.erb" })

end
def items 
  input_string = params.fetch("query_name").gsub(/\d/, "").split(",").map(&:strip).map(&:downcase)

  matching_items = []
  input_string.each do |word|
    matching_items.concat(Item.where("LOWER(name) LIKE ?", "%#{word}%"))
  end

  @list_of_items = matching_items
  render({ :template => "items/display.html.erb" })

end

end
