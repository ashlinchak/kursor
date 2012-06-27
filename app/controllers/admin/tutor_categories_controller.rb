class Admin::TutorCategoriesController < Admin::DashboardController

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if tutor_category.save
      flash[:success] = 'Tutor category was successfully created.'
      redirect_to admin_tutor_categories_path
    else
      render :action => "new"
    end
  end

  def update
    if tutor_category.update_attributes(params[:tutor_category])
      flash[:success] = 'Tutor Category was successfully updated.'
      redirect_to admin_tutor_categories_path
    else
      render :action => "edit"
    end
  end

  def destroy
    unless (tutor_category.children.size > 0) || (tutor_category.tutors.size > 0)
      tutor_category.destroy
    else
      flash[:error] = 'Can\'t delete non-empty category'
    end
    redirect_to admin_tutor_categories_path
  end

  private

  def tutor_categories
    @tutor_categories = if params[:id]
    else
      root_tutor_categories
    end
  end
  helper_method :tutor_categories

  def tutor_category
    @tutor_category = if params[:id]
      TutorCategory.find_by_permalink(params[:id])
    else
      TutorCategory.new(params[:tutor_category])
    end
  end
  helper_method :tutor_category


end
