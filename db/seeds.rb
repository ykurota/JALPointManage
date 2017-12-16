# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Flightclass.create(:flightclass =>'ファーストクラス', :classcode => 'F・A', :addon => '150')
Flightclass.create(:flightclass =>'ビジネスクラス1', :classcode => 'J・C・D・X', :addon => '125')
Flightclass.create(:flightclass =>'ビジネスクラス2', :classcode => 'I', :addon => '70')
Flightclass.create(:flightclass =>'プレミアムエコノミークラス', :classcode => 'E', :addon => '100')
Flightclass.create(:flightclass =>'エコノミークラス1', :classcode => 'W・Y・B', :addon => '100')
Flightclass.create(:flightclass =>'エコノミークラス2', :classcode => 'H・K・M', :addon => '70')
Flightclass.create(:flightclass =>'エコノミークラス3', :classcode => 'L・V・S', :addon => '50')
Flightclass.create(:flightclass =>'エコノミークラス4', :classcode => 'O・G・R', :addon => '50')
Flightclass.create(:flightclass =>'エコノミークラス5', :classcode => 'Q・N', :addon => '30')