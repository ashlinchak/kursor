class Admin::CustomFieldsController < Admin::DashboardController

  def index
  end

  def show
  end

  def new
  end

  def create
    if custom_field.save
      redirect_to admin_custom_fields_path, :success => 'Field created!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if custom_field.update_attributes(params[:custom_field])
      redirect_to admin_custom_fields_path, :success => 'Field saved!'
    else
      render :edit
    end
  end

  def destroy
    custom_field.destroy
    redirect_to admin_custom_fields_path
  end

  def sort
    params[:'sorted-item'].each_with_index do |item, index|
      todo_item = ::CustomField.find(item)
      todo_item.update_attribute :position, index
    end if params[:'sorted-item']
    render :nothing => true
  end

  private

  def custom_fields
    @custom_fields ||= ::CustomField.all
  end
  helper_method :custom_fields

  def custom_field
    @custom_field ||= if params[:id]
      ::CustomField.find params[:id]
    else
      ::CustomField.new params[:custom_field]
    end
  end
  helper_method :custom_field
end
