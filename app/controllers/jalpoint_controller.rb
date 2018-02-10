class JalpointController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :edit, :update, :delete]
	layout 'jalpoint'
  
=begin
    def initialize
      puts "start initialize"
      super
      begin
        puts "begin"
        #@registeredmileage = '0'
        #@user = current_user
        #@mile = Mile.all
        @mile = Mile.where(username: @user.email)
        #@jalpoint_data = JSON.parse(File.read("data.txt"))
        t = Mile.arel_table
        @total = Mile.where(username: @user.email).select([t[:registeredmileage].sum.as('registeredmileage'),
          t[:registeredfop].sum.as('registeredfop')]).all[0]
        puts "begin-end"
      rescue
        #@jalpoint_data = Hash.new
        #@mile = Hash.new
        #@total = Hash.new
        puts "rescue"
        #reset_session
        #redirect_to '/users/sign_in'
      end
begin
      @jalpoint_data.each do |key,obj|
        if Time.now.to_i - key.to_i > 24*60*60 then
          @jalpoint_data.delete(key)
        end

      end
      File.write("data.txt", @jalpoint_data.to_json)
end
    end
=end

def edit
  puts 'edit'
  @user = current_user
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
  @user = current_user
  dpt = params['departure']
  dst = params['destination']
  flc = params['flightclass']
  mlg = params['mileage']
  dptara = City.select('area').find_by(cityname: dpt)
  dstara = City.select('area').find_by(cityname: dst)
  @registeredmileage = mlg.to_i
  @registeredfop = mlg.to_i
  if !dpt.empty? && !dst.empty? && !flc.empty? && !mlg.empty? \
     && (dptara.area == 'japan' || dstara.area == 'japan') then
    puts 'calpoint2'
    if dptara.area == 'japan' then
      ara = dstara
    else
      ara = dptara
    end
    fopmbp = Campaign.select('bpoint').find_by(ctypedetail: ara.area)
    foppbp = Campaign.where(bway: "+fop").sum(:bpoint)
    mlgadn = Flightclass.select('addon').find_by(flightclass: flc)
    mlgcrd = Campaign.select('bpoint').find_by(ctype: 'JALCard')
    mlgadclas = mlg.to_f * mlgadn.addon.to_f / 100
    fregisteredmileage = mlgadclas * mlgcrd.bpoint.to_f
    @registeredmileage = fregisteredmileage.ceil.to_i
    puts 'registered'
    fregisteredfop = mlgadclas * fopmbp.bpoint.to_f + foppbp.to_f
    @registeredfop = fregisteredfop.ceil.to_i
  end
  data = {:registeredmileage => @registeredmileage, :registeredfop => @registeredfop}
  render :json => data
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
:registeredfop,
:price)
end


  def index
      puts "index"
      @user = current_user
      @total = {'registeredmileage' => 0, 'registeredfop' => 0}
      #@mile = Mile.all
      @mile = Mile.where(username: @user.email).order('flightdate')
      if request.post? then
        obj = MyData.new(
          user:@user.email,
          flightdate:params['flightdate'],
          departure:params['departure'],
          destination:params['destination'],
          flightclass:params['flightclass'],
          mileage:params['mileage'],
          registeredmileage:params['registeredmileage'],
          fop:params['fop'],
          registeredfop:params['registeredfop'],
          price:params['price'])

        @mileobj = Mile.create(
          username:@user.email,
          flightdate:params['flightdate'],
          departure:params['departure'],
          destination:params['destination'],
          flightclass:params['flightclass'],
          mileage:params['mileage'],
          registeredmileage:params['registeredmileage'],
          fop:params['mileage'],
          registeredfop:params['registeredfop'],
          price:params['price'],
          registereduser:params['user'],
          updateuser:params['user'],
          created_at:params[Time.now],
          updated_at:params[Time.now])
      end
      t = Mile.arel_table
      @ttlmilval = Mile.where('username = ? and flightdate >= date(now() - interval 36 month) 
                          and flightdate <= date(now())',
                          @user.email).select([t[:registeredmileage].sum.as('registeredmileage')]).all[0]
      @ttlmilest = Mile.where('username = ? and flightdate >= date(now() - interval 36 month)',
                          @user.email).select([t[:registeredmileage].sum.as('registeredmileage')]).all[0]
      @nowrank = Mile.where('username = ? and flightdate >= year(date(now())) and flightdate <= date(now())',
                          @user.email).select([t[:registeredfop].sum.as('nowfop')]).all[0]
      puts 'put nowrank'
      puts @nowrank.nowfop
      @total = Mile.where('username = ? and flightdate >= date(now() - interval 1 year)',
                          @user.email).select(['year(flightdate) as year',
                          t[:registeredfop].sum.as('registeredfop'),
                          t[:price].sum.as('price')]).group('year(flightdate)').order('year')
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
    attr_accessor :price

    def initialize user:user, flightdate:flightdate, departure:departure, 
      destination:destination, flightclass:flightclass, mileage:mileage, 
      registeredmileage:registeredmileage, fop:fop, registeredfop:registeredfop, price:price
      self.user = user
      self.flightdate = flightdate
      self.departure = departure
      self.destination = destination
      self.flightclass = flightclass
      self.mileage = mileage
      self.registeredmileage = registeredmileage
      self.fop = fop
      self.registeredfop = registeredfop
      self.price = price
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