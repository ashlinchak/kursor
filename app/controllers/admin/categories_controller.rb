class Admin::CategoriesController < Admin::DashboardController

  require 'csv'

  def index
  end

  def show
  end

  def new
    category.build_metatag
  end

  def edit
    category.build_metatag unless category.metatag.present?
  end

  def create
    if category.save
      flash[:success] = 'category was successfully created.'
      redirect_to admin_categories_path
    else
      render :action => "new"
    end
  end

  def update
    if category.update_attributes(params[:category])
      flash[:success] = 'Category was successfully updated.'
      redirect_to admin_category_path(category)
    else
      render :action => "edit"
    end
  end

  def destroy
    unless (category.children.size > 0) || (category.providers.size > 0)
      category.destroy
    else
      flash[:error] = 'Can\'t delete non-empty category'
    end
    redirect_to admin_categories_path
  end

  def sort
    params[:'sorted-item'].each_with_index do |item, index|
      todo_item = ::Category.find(item)
      todo_item.update_attribute :position, index
    end if params[:'sorted-item']
    render :nothing => true
  end

  def export

    @contacts = []

    providers.each do |provider|
      @contacts << provider.contacts.find_by_contact_type_id(1) unless provider.contacts.find_by_contact_type_id(1).nil?
    end

    @string = StringIO.new

    @string = CSV.generate do |csv|
      @contacts.each do |contact|
        prov = Provider.find(contact.contactable_id)
        csv << [contact.value, prov.name, provider_url(prov)]
      end
    end

    respond_to do |format|
      format.html
      format.csv { send_data @string }
    end

  end

  private

  def categories
    @categories ||= if params[:id]
    else
      root_categories
    end
  end
  helper_method :categories

  def category
    @category ||= if params[:id]
      Category.find_by_permalink(params[:id])
    else
      Category.new(params[:category])
    end
  end
  helper_method :category

  def providers
    if category.root?
      category.providers
    else
      category.sub_providers
    end
  end
  helper_method :providers

end
