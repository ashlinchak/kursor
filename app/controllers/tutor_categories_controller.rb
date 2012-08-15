class TutorCategoriesController < ApplicationController

  def show
    respond_to do |format|
      format.html
      format.json { render :json => categories }
    end
  end

  private

  def tutor_categories
    @tutor_categories ||= if params[:id]
       tutor_category.children
    else
      root_tutor_categories
    end
  end
  helper_method :tutor_categories

  def tutor_category
    @tutor_category ||= if params[:id]
      TutorCategory.find_by_permalink!(params[:id])
    else
      TutorCategory.new(params[:tutor_categories])
    end
  end
  helper_method :tutor_category

  def tutors
    @tutors ||= unless filter
      if tutor_category.root?
        Kaminari.paginate_array(tutor_category.tutors.approved.order("updated_at desc")).page(params[:page]).per(30)
      else
        Kaminari.paginate_array(tutor_category.sub_tutors.approved.order("updated_at desc")).page(params[:page]).per(30)
      end
    else

    # Providers sorting  by City and Region in current category

      if  !filter[:city_id].blank?
        addressables = Address::Location.where(:city_id => filter[:city_id]).map(&:addressable)
      else
        filtered_cities = Address::City.where(:region_id => filter[:region_id])
        addressables = Address::Location.where(:city_id => filtered_cities).map(&:addressable)
      end

      tutors = []

      addressables.each do |a|
        if a.is_a? Tutor
          if a.tutor_categories.include? tutor_category or a.tutor_category == tutor_category
            unless a.is_approved == false
              tutors << a
            end
          end
        end
      end

      Kaminari.paginate_array(tutors.sort_by{|t| -t.updated_at.to_i}).page(params[:page]).per(30)

    end

  end
  helper_method :tutors

  def filter
    @filter ||= params[:filter] || {}
  end
  helper_method :filter

end
