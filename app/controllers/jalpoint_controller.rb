class JalpointController < ApplicationController
	layout 'jalpoint'
  

    def initialize
      puts "start initialize"
      super
      begin
        @mile = Mile.all
        #@jalpoint_data = JSON.parse(File.read("data.txt"))
        t = Mile.arel_table
        @total = Mile.select([t[:registeredmileage].sum.as('registeredmileage'),
          t[:registeredfop].sum.as('registeredfop')]).all[0]
      rescue
        #@jalpoint_data = Hash.new
        @mile = Hash.new
        @total = Hash.new
        puts "rescue"
      end
=begin
      @jalpoint_data.each do |key,obj|
        if Time.now.to_i - key.to_i > 24*60*60 then
          @jalpoint_data.delete(key)
        end

      end
      File.write("data.txt", @jalpoint_data.to_json)
=end
    end


def edit
  puts 'edit'
  @mile = Mile.find(params[:id])
end

def update
  puts 'update'
  @obj = Mile.find(params[:id])
  if @obj.update(mile_params) then
    redirect_to '/jalpoint'
  else
    puts @obj.id
    updateurl = '/jalpoint/edit/' + @obj.id.to_s
    puts updateurl
    redirect_to updateurl
  end
end

def delete
  @obj = Mile.find(params[:id])
  @obj.destroy
  redirect_to '/jalpoint'
end

def calpoint
  puts 'calpoint'
  dpt = params['departure']
  dst = params['destination']
  flc = params['flightclass']
  mlg = params['mileage']
  if !dpt.empty? && !dst.empty? && !flc.empty? && !mlg.empty? \
     && (dpt.in?(['羽田','成田']) || dst.in?(['羽田','成田'])) then
    puts 'calpoint2'
    if dpt.in?(['羽田','成田']) then
      puts dst
      ara = City.select('area').find_by(cityname: dst)
    else
      puts dpt
      ara = City.select('area').find_by(cityname: dpt)
    end
    puts ara.area
    fopmbp = Campaign.select('bpoint').find_by(ctypedetail: ara.area)
    foppbp = Campaign.where(bway: "+fop").sum(:bpoint)
    puts fopmbp.bpoint
    puts foppbp
    mlgadn = Flightclass.select('addon').find_by(flightclass: flc)
    mlgcrd = Campaign.select('bpoint').find_by(ctype: 'JALCard')
    puts mlgadn.addon
    registeredmileage = mlg.to_f * mlgadn.addon.to_f / 100 * mlgcrd.bpoint.to_f
    puts 'registered'
    puts registeredmileage
    registeredfop = mlg.to_f * fopmbp.bpoint.to_f + foppbp.to_f
    puts registeredfop

  end 
end

def mile_params
params.require(:mile).permit(:username, 
:flightdate,
:departure,
:destination,
:flightclass,
:mileage,
:registeredmileage,
:fop,
:registeredfop)
end


    def index
      puts "index"
      @mile = Mile.all
      if request.post? then
        obj = MyData.new(
          user:params['user'],
          flightdate:params['flightdate'],
          departure:params['departure'],
          destination:params['destination'],
          flightclass:params['flightclass'],
          mileage:params['mileage'],
          registeredmileage:params['registeredmileage'],
          fop:params['fop'],
          registeredfop:params['registeredfop'])
        #@jalpoint_data[Time.now.to_i] = obj
        #data = @jalpoint_data.to_json
        #File.write("data.txt", data)
        #@jalpoint_data = JSON.parse(data)

        @mileobj = Mile.create(
          username:params['user'],
          flightdate:params['flightdate'],
          departure:params['departure'],
          destination:params['destination'],
          flightclass:params['flightclass'],
          mileage:params['mileage'],
          registeredmileage:params['registeredmileage'],
          fop:params['mileage'],
          registeredfop:params['registeredfop'],
          registereduser:params['user'],
          updateuser:params['user'],
          created_at:params[Time.now],
          updated_at:params[Time.now])
      end
      t = Mile.arel_table
      @total = Mile.select([t[:registeredmileage].sum.as('registeredmileage'),
        t[:registeredfop].sum.as('registeredfop')]).all[0]
      puts "test"
      puts @total.registeredmileage
      puts @total.registeredfop
    end     
  end



  class MyData
    #attr_accessorはMyData.newとかの属性を作るもの
    attr_accessor :user
    attr_accessor :flightdate
    attr_accessor :departure
    attr_accessor :destination
    attr_accessor :flightclass
    attr_accessor :mileage
    attr_accessor :registeredmileage
    attr_accessor :fop
    attr_accessor :registeredfop

    def initialize user:user, flightdate:flightdate, departure:departure, 
      destination:destination, flightclass:flightclass, mileage:mileage, 
      registeredmileage:registeredmileage, fop:fop, registeredfop:registeredfop
      self.user = user
      self.flightdate = flightdate
      self.departure = departure
      self.destination = destination
      self.flightclass = flightclass
      self.mileage = mileage
      self.registeredmileage = registeredmileage
      self.fop = fop
      self.registeredfop = registeredfop
    end
end
=begin
class MileData
  attr_accessor :id
  attr_accessor :username
  attr_accessor :flightdate
  attr_accessor :departure
  attr_accessor :destination
  attr_accessor :flightclass
  attr_accessor :mileage
  attr_accessor :registeredmileage
  attr_accessor :fop
  attr_accessor :registeredfop
  attr_accessor :updateuser
  attr_accessor :registereddate
  attr_accessor :updatedate
end
=end