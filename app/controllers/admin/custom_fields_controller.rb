class Admin::CustomFieldsController < ApplicationController

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
