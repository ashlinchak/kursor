# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

admin = User.create( :email => 'admin@kursor.ua', :password => 'admin', :password_confirmation => 'admin' )

Administrator.create( :user => admin )

Address::Region.create([
  { :name => 'Киевская область' },
  { :name => 'АР Крым' },
  { :name => 'Винницкая область' },
  { :name => 'Волынская область' },
  { :name => 'Днепропетровская область' },
  { :name => 'Донецкая область' },
  { :name => 'Житомирская область' },
  { :name => 'Закарпатская область' },
  { :name => 'Запорожская область' },
  { :name => 'Ивано-Франковская область' },
  { :name => 'Кировоградская область' },
  { :name => 'Луганская область' },
  { :name => 'Львовская область' },
  { :name => 'Николаевская область' },
  { :name => 'Одесская область' },
  { :name => 'Полтавская область' },
  { :name => 'Ровенская область' },
  { :name => 'Сумская область' },
  { :name => 'Тернопольская область' },
  { :name => 'Харьковская область' },
  { :name => 'Херсонская область' },
  { :name => 'Хмельницкая область' },
  { :name => 'Черкасская область' },
  { :name => 'Черниговская область' },
  { :name => 'Черновицкая область' }
])

Address::City.create([
  {:name => 'Киев', :region=> Address::Region.find_by_name('Киевская область') },
  {:name => 'Винница', :region=> Address::Region.find_by_name('Винницкая область')},
  {:name => 'Днепропетровск', :region=> Address::Region.find_by_name('Днепропетровская область') },
  {:name => 'Донецк', :region=> Address::Region.find_by_name('Донецкая область') },
  {:name => 'Житомир', :region=> Address::Region.find_by_name('Житомирская область') },
  {:name => 'Запорожье', :region=> Address::Region.find_by_name('Запорожская область') },
  {:name => 'Ивано-Франковск', :region=> Address::Region.find_by_name('Ивано-Франковская область') },
  {:name => 'Кировоград', :region=> Address::Region.find_by_name('Кировоградская область') },
  {:name => 'Луганск', :region=> Address::Region.find_by_name('Луганская область')},
  {:name => 'Львов', :region=> Address::Region.find_by_name('Львовская область')},
  {:name => 'Николаев', :region=> Address::Region.find_by_name('Николаевская область')},
  {:name => 'Одесса', :region=> Address::Region.find_by_name('Одесская область')},
  {:name => 'Луцк', :region=> Address::Region.find_by_name('Волынская область')},
  {:name => 'Ужгород', :region=> Address::Region.find_by_name('Закарпатская область')},
  {:name => 'Полтава', :region=> Address::Region.find_by_name('Полтавская область')},
  {:name => 'Ровно', :region=> Address::Region.find_by_name('Ровенская область')},
  {:name => 'Сумы', :region=> Address::Region.find_by_name('Сумская область')},
  {:name => 'Тернополь', :region=> Address::Region.find_by_name('Тернопольская область')},
  {:name => 'Харьков', :region=> Address::Region.find_by_name('Харьковская область')},
  {:name => 'Херсон', :region=> Address::Region.find_by_name('Херсонская область')},
  {:name => 'Хмельницкий', :region=> Address::Region.find_by_name('Хмельницкая область')},
  {:name => 'Черкассы', :region=> Address::Region.find_by_name('Черкасская область')},
  {:name => 'Чернигов', :region=> Address::Region.find_by_name('Черниговская область')},
  {:name => 'Черновцы', :region=> Address::Region.find_by_name('Черновицкая область')}
  {:name => 'Симферополь', :region=> Address::Region.find_by_name('АР Крым')},
  {:name => 'Севастополь', :region=> Address::Region.find_by_name('АР Крым')},
  {:name => 'Ялта', :region=> Address::Region.find_by_name('АР Крым')}
])
