# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Category.create([
  {:name => 'Курсы',      :description => 'Различные обучающие курсы', :permalink => 'courses'},
  {:name => 'Школы',      :description => 'Образовательные частные и государственные школы', :permalink => 'schools'},
  {:name => 'ЗНО',        :description => 'Различные ЗНО', :permalink => 'zno'},
  {:name => 'ВУЗы',       :description => 'Частные и государственные ВУЗы', :permalink => 'high-schools'},
  {:name => 'Репетиторы', :description => 'Репетиторы и частные преподаватели', :permalink => 'teachers'},
  {:name => 'Автошколы',  :description => 'Школы вождения, экстремального вождения', :permalink => 'auto-schools'}
])

User.create( :email => 'ivan.kukobko@gmail.com', :password => '111111', :password_confirmation => '111111' )

admin = User.create( :email => 'admin@kursor.ua', :password => 'admin', :password_confirmation => 'admin' )
Administrator.create( :user => admin )
