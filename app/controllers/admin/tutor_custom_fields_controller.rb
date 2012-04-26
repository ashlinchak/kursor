class Admin::TutorCustomFieldsController < Admin::DashboardController

  def index
  end

  def show
  end

  def new
  end

  def create
    if tutor_custom_field.save
      redirect_to admin_tutor_custom_fields_path, :success => 'Field created!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if tutor_custom_field.update_attributes(params[:tutor_custom_field])
      redirect_to admin_tutor_custom_fields_path, :success => 'Field saved!'
    else
      render :edit
    end
  end

  def destroy
    tutor_custom_field.destroy
    redirect_to admin_tutor_custom_fields_path
  end

  def sort
    params[:'sorted-item'].each_with_index do |item, index|
      todo_item = ::TutorCustomField.find(item)
      todo_item.update_attribute :position, index
    end if params[:'sorted-item']
    render :nothing => true
  end

  private

  def tutor_custom_fields
    @tutor_custom_fields ||= ::TutorCustomField.all
  end
  helper_method :tutor_custom_fields

  def tutor_custom_field
    @tutor_custom_field ||= if params[:id]
      ::TutorCustomField.find params[:id]
    else
      ::TutorCustomField.new params[:tutor_custom_field]
    end
  end
  helper_method :tutor_custom_field
end
