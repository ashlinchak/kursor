class Admin::CustomFlagsController < Admin::DashboardController

  def index
  end

  def show
  end

  def new
  end

  def create
    if custom_flag.save
      redirect_to admin_custom_flags_path, :success => 'Flag created!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if custom_flag.update_attributes(params[:custom_flag])
      redirect_to admin_custom_flags_path, :success => 'Field saved!'
    else
      render :edit
    end
  end

  def destroy
    custom_flag.destroy
    redirect_to admin_custom_flags_path
  end

  def sort
    params[:'sorted-item'].each_with_index do |item, index|
      todo_item = ::CustomFlag.find(item)
      todo_item.update_attribute :position, index
    end if params[:'sorted-item']
    render :nothing => true
  end

  private

  def custom_flags
    @custom_flags ||= ::CustomFlag.all
  end
  helper_method :custom_flags

  def custom_flag
    @custom_flag ||= if params[:id]
      ::CustomFlag.find params[:id]
    else
      ::CustomFlag.new params[:custom_flag]
    end
  end
  helper_method :custom_flag
end
