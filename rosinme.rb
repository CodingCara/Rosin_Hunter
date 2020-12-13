require 'wannabe_bool'
require 'httparty'
require 'sqlite3'
require 'json'
require 'colorize'
require 'pry'
require 'watir'

#Create INSERT for THC/CBD content linked via ProductID in a different able. Or perhaps in a productID table itself, with a new schema?

@dispensaries = []
@final_holder = []


@the_key, @ProductBrand, @ProductType, @ProductSubCategory, @ProductName, @loopcounter = String.new

@dispensaries << {:id => "89eEAwyWdNydEBzNE", :name => "Mr. Nice Guy (Portland - SE Woodstock)", :url => "https://dutchie.com/dispensaries/mr-nice-guy-portland-se-woodstock/menu"}
@dispensaries << {:id => "5e7b9bd0bde0d600980d8982", :name => "Electric Lettuce - Weilder", :url => "https://dutchie.com/dispensaries/electric-lettuce-weidler-st/menu"}
@dispensaries << {:id => "N8iYxkzdbDMkDo8je", :name => "Homegrown Oregon (Beaverton)", :url => "https://dutchie.com/dispensaries/homegrown-beaverton/menu"} 
@dispensaries << {:id => "5e7b9c65ff1d7400bedc3145", :name => "Farma", :url => "https://dutchie.com/dispensaries/farma/menu"}
@dispensaries << {:id => "5e838597f3b57c00c01db92c", :name => "Serra (Downtown Portland)", :url => "https://dutchie.com/dispensaries/serra-downtown-portland/menu"}
@dispensaries << {:id => "5ee93c37e589a800e305cc8a", :name => "Electric Lettuce - Old Town", :url => "https://dutchie.com/dispensaries/electric-lettuce-old-town/menu"}
@dispensaries << {:id => "5e6fc7f304402800778626a0", :name => "Bridge City Collective - SE Portland", :url => "https://dutchie.com/dispensaries/bridge-city-collective-se-portland/menu"}
@dispensaries << {:id => "zFk76cu6yK4swFRiN", :name => "Kaya Shack (Portland)", :url => "https://dutchie.com/dispensaries/kaya-shack-portland/menu"}
@dispensaries << {:id => "5f971881dd531000d97c650b", :name => "Broadway Cannabis Market", :url => "https://dutchie.com/dispensaries/broadway-cannabis-market/menu"}
@dispensaries << {:id => "ENWqnaKeFuJQuQ9fH", :name => "Pakalolo (Holgate Blvd)", :url => "https://dutchie.com/dispensaries/pakalolo/menu"}
@dispensaries << {:id => "fHE6RfjtfNpwKKt5K", :name => "Cannabliss & Co (22nd & Burn)", :url => "https://dutchie.com/dispensaries/cannabliss-and-co-22nd-and-burn/menu"}
@dispensaries << {:id => "ca5hYarcJmP5Qzqax", :name => "Oregons Finest (Convention Center)", :url => "https://dutchie.com/dispensaries/oregons-finest-convention-center/menu"}
@dispensaries << {:id => "QBoTaLFJW5EgJxRop", :name => "Oregons Finest (Pearl Dispensary)", :url => "https://dutchie.com/dispensaries/oregons-finest/menu"}
@dispensaries << {:id => "5e7296f7d0e028008418f81c", :name => "Serra (Belmont St - Portland)", :url => "https://dutchie.com/dispensaries/serra-belmont-or/menu"}
@dispensaries << {:id => "f3DCDthdTRkPB2SBD", :name => "MindRite", :url => "https://dutchie.com/dispensaries/mindrite/menu"}
@dispensaries << {:id => "5e7aa0f44f8e0900b7e04a79", :name => "Somewhere PDX", :url => "https://dutchie.com/dispensaries/somewhere-pdx/menu"}
@dispensaries << {:id => "kHx9t88rZ6awXvAKa", :name => "Papa Buds", :url => "https://dutchie.com/dispensaries/papa-buds/menu"}
@dispensaries << {:id => "5f6a519a8fb97b0111dc3ae6", :name => "Electric Lettuce - Sellwood", :url => "https://dutchie.com/dispensaries/electric-lettuce-sellwood/menu"}
@dispensaries << {:id => "5e8cf2cf0b2768009a4ad93e", :name => "Tetra Cannabis (Belmont)", :url => "https://dutchie.com/dispensaries/tetra-cannabis/menu"}
@dispensaries << {:id => "5ecaf565cb9c1b00e1080b7c", :name => "Pot Mates", :url => "https://dutchie.com/dispensaries/pot-mates/menu"}
@dispensaries << {:id => "xRfhGAx5zict2K5r3", :name => "Nectar - Beaverton Hillsdale", :url => "https://dutchie.com/dispensaries/nectar-hillsdale/menu"}
@dispensaries << {:id => "CKQGjaE9GBcsEqcGB", :name => "Nectar - Sandy", :url => "https://dutchie.com/dispensaries/nectar-portland-sandy-blvd/menu"}
@dispensaries << {:id => "Y5ZmfrHiygRCpTW3A", :name => "La Mota (NW Front)", :url => "https://dutchie.com/dispensaries/la-mota-nw-front/menu"}
@dispensaries << {:id => "zghKZ9q3dM5YxsnbG", :name => "Nectar - Terwilliger", :url => "https://dutchie.com/dispensaries/nectar-burlingame/menu"}
@dispensaries << {:id => "TmS5Kcar8tEr8uxfJ", :name => "VIBE - Amberlight", :url => "https://dutchie.com/dispensaries/amberlight-cannabis-house/menu"}
@dispensaries << {:id => "5e7ba1326e447b60db4fe9bf", :name => "Five Zero Trees - SW Portland", :url => "https://dutchie.com/dispensaries/five-zero-trees-sw-portland/menu"}
@dispensaries << {:id => "5e7ba01f6e5f2100a7212fae", :name => "Electric Lettuce - Foster - Powell", :url => "https://dutchie.com/dispensaries/electric-lettuce-foster-powell/menu"}
@dispensaries << {:id => "5e6fc7883f8979007a172c1e", :name => "Bridge City Collective - N WIlliams", :url => "https://dutchie.com/dispensaries/bridge-city-collective/menu"}
@dispensaries << {:id => "89eEAwyWdNydEBzNE", :name => "La Mota (Hollywood)", :url => "https://dutchie.com/dispensaries/la-mota-hollywood/menu"}
@dispensaries << {:id => "r9X4EhpBEzkhG7MGC", :name => "La Mota (Johnson Creek)", :url => "https://dutchie.com/dispensaries/la-mota-johnson-creek/menu"}
@dispensaries << {:id => "5e837decde402e00a87a0c32", :name => "Electric Lettuce - Alberta Arts District", :url => "https://dutchie.com/dispensaries/electric-lettuce-alberta/menu"}
@dispensaries << {:id => "ZMaB6fPzHSfFqWngG", :name => "La Mota (SE Portland)", :url => "https://dutchie.com/dispensaries/la-mota-se-portland/menu"}
@dispensaries << {:id => "ze8wN7pb8Y2M9cP5B", :name => "The New Amsterdam", :url => "https://dutchie.com/dispensaries/the-new-amsterdam/menu"}
@dispensaries << {:id => "5e7b9faa4d6325009a878672", :name => "Foster Buds - NE Glisan St", :url => "https://dutchie.com/dispensaries/foster-buds-glisan-st/menu"}
@dispensaries << {:id => "5e7ba1aaed7b5400afa9c7f0", :name => "Five Zero Trees - Dekum St", :url => "https://dutchie.com/dispensaries/five-zero-trees-dekum-st/menu"}
@dispensaries << {:id => "5e6be93acdc3af00712fe275", :name => "The People's Dispensary (Portland)", :url => "https://dutchie.com/dispensaries/peoples-dispensary-portland/menu"}
@dispensaries << {:id => "5fa5d4a1e7895000ece0b666", :name => "Top Hat Express", :url => "https://dutchie.com/dispensaries/top-hat-express1/menu"}
@dispensaries << {:id => "5e7b8dfe49f75e00bbdb7b9e", :name => "Electric Lettuce - Cedar Hills", :url => "https://dutchie.com/dispensaries/electric-lettuce-marlow-ave/menu"}
@dispensaries << {:id => "5eb33c2258a5f300e86f6ac5", :name => "Five Zero Trees (East Portland)", :url => "https://dutchie.com/dispensaries/five-zero-trees-east-portland/menu"}
@dispensaries << {:id => "cgooXmKenGs48qvZf", :name => "Chalice Farms (Downtown)", :url => "https://dutchie.com/dispensaries/chalice-farms-downtown/menu"}
@dispensaries << {:id => "GbjYW7MF3mBtNogmk", :name => "Cannabliss (Firestation 23)", :url => "https://dutchie.com/dispensaries/cannabliss-and-co-firestation-23/menu"}
@dispensaries << {:id => "5e7c0b6dd4bcd700b4a3be73", :name => "Truly Pure", :url => "https://dutchie.com/dispensaries/truly-pure1/menu"}
@dispensaries << {:id => "kgtGfbPx92Z2zMb8X", :name => "Diem Delivery", :url => "https://dutchie.com/dispensaries/diem-portland/menu"}
@dispensaries << {:id => "gM9rZFpEyZWL36B6R", :name => "Attis Trading Co (Gladstone)", :url => "https://dutchie.com/dispensaries/attis-trading-co-gladstone/menu"}
@dispensaries << {:id => "DCernomKcb4hPQgW9", :name => "Attis Trading Co (Barbur)", :url => "https://dutchie.com/dispensaries/attis-trading-co-barbur/menu"}
@dispensaries << {:id => "FeADLqAA74sqwWuNb", :name => "TJs on Powell", :url => "https://dutchie.com/dispensaries/tjs-on-powell/menu"}
@dispensaries << {:id => "zaszMhfCbuLdD3Dpb", :name => "Cannabliss Co (The Blvd)", :url => "https://dutchie.com/dispensaries/cannabliss-and-co-the-blvd/menu"}
@dispensaries << {:id => "Yn3jEf88Eqa3APASZ", :name => "Deanz Greenz (Foster)", :url => "https://dutchie.com/dispensaries/deanz-greenz-foster/menu"}
@dispensaries << {:id => "mrRCfw9orrg6ZPQWK", :name => "Left Coast Connection", :url => "https://dutchie.com/dispensaries/left-coast-connection/menu"}
@dispensaries << {:id => "5ea22aff790b8f00dd98f598", :name => "SWED CO", :url => "https://dutchie.com/dispensaries/swedco/menu"}
@dispensaries << {:id => "zBKaBM3hTpspDwMED", :name => "Natural RXemedies", :url => "https://dutchie.com/dispensaries/natural-remedies/menu"}
@dispensaries << {:id => "D8RQfZ6Kftnxeof2P", :name => "Oregrown (Portland)", :url => "https://dutchie.com/dispensaries/oregrown-portland/menu"}
@dispensaries << {:id => "zKjLfByt2tvgmiQvt", :name => "Chalice Farms (Powell)", :url => "https://dutchie.com/dispensaries/chalice-farms-powell/menu"}
@dispensaries << {:id => "5NFnoMgMWbTrT6Ftb", :name => "Urban Farmacy", :url => "https://dutchie.com/dispensaries/urban-farmacy/menu"}
@dispensaries << {:id => "SSexAhLYfSzoLqm9o", :name => "Deanz Greenz (Sandy)", :url => "https://dutchie.com/dispensaries/deanz-greenz-sandy/menu"}

DB = SQLite3::Database.open("dutchie_test1.db")

def menu_dump(caneme)

@response = HTTParty.get(@the_key)
@menu = JSON.parse(@response.body)

end

def sacrificial_lamb()

@browser = Watir::Browser.new :chrome, headless: true
puts "Opened Browser!".green

end


def open_the_gates(caneme)

@browser.goto(caneme[:url])
sleep(5)
script = 'var performance = window.performance || window.mozPerformance || window.msPerformance || window.webkitPerformance || {}; return performance.getEntries().filter(e=>e.initiatorType=="xmlhttprequest")'
stripper = @browser.execute_script(script)

stripper.each do |recruit|
if recruit["name"].include?("sha256Hash%22%3A%22") and recruit["name"].include?("FilteredProducts")
	puts "Found a key!".green
	@the_key = recruit["name"].to_s

	
end

end
end

def sanitizemecaptain(crush)
#puts crush
if crush.nil? != true && crush.include?("'")
#puts "Not Nil - Brand".green
	crush.gsub!("'", "")
#puts crush
end
end

sacrificial_lamb()

@dispensaries.each do |caneme|

open_the_gates(caneme)


menu_dump(caneme)

@loopcounter = @menu["data"]["filteredProducts"]["products"]
if @loopcounter.nil? == true || @loopcounter.empty? == true
next caneme
end
@loopcounter = @menu["data"]["filteredProducts"]["products"].count


puts caneme[:name]

for circles in 0..@loopcounter-1


@ProductType = @menu["data"]["filteredProducts"]["products"][circles]["type"]
sanitizemecaptain(@ProductType)

if @ProductType == "Accessories" || @ProductType == "Apparel" || @ProductType == "Topicals" || @ProductType == "Edibles" || @ProductType == "Pre-Rolls"
	next circles
end


@ProductBrand = @menu["data"]["filteredProducts"]["products"][circles]["brandName"]
@DispensaryID = @menu["data"]["filteredProducts"]["products"][circles]["DispensaryID"]
@ProductID = @menu["data"]["filteredProducts"]["products"][circles]["id"]
@ProductImage = @menu["data"]["filteredProducts"]["products"][circles]["Image"]
@ProductQuantityOptions = @menu["data"]["filteredProducts"]["products"][circles]["Options"]
@ProductMedicalPrices = @menu["data"]["filteredProducts"]["products"][circles]["medicalPrices"]
@ProductMedicalSpecialPrices = @menu["data"]["filteredProducts"]["products"][circles]["medicalSpecialPrices"]
@ProductRecPrices = @menu["data"]["filteredProducts"]["products"][circles]["recPrices"]
@ProductRecSpecialPrices = @menu["data"]["filteredProducts"]["products"][circles]["recSpecialPrices"]
@IsSpecial = @menu["data"]["filteredProducts"]["products"][circles]["special"].to_b
@ProductStatus = @menu["data"]["filteredProducts"]["products"][circles]["Status"]
@ProductSubCategory = @menu["data"]["filteredProducts"]["products"][circles]["subcategory"]
@ProductName = @menu["data"]["filteredProducts"]["products"][circles]["Name"]
@ProductQuantityAvailable = @menu["data"]["filteredProducts"]["products"][circles]["POSMetaData"]
@ProductQuantityAvailableOverride = @menu["data"]["filteredProducts"]["products"][circles]["manualInventory"]

sanitizemecaptain(@ProductQuantityOptions[0])
sanitizemecaptain(@ProductQuantityOptions[1])
sanitizemecaptain(@ProductQuantityOptions[2])
sanitizemecaptain(@ProductQuantityOptions[3])
sanitizemecaptain(@ProductQuantityOptions[4])
sanitizemecaptain(@ProductQuantityOptions[5])
sanitizemecaptain(@ProductQuantityOptions[6])
sanitizemecaptain(@ProductQuantityOptions[7])
sanitizemecaptain(@ProductBrand)
sanitizemecaptain(@ProductName)

if @ProductQuantityAvailable.nil? == true || @ProductQuantityAvailable.empty? == true
	@ProductQuantityAvailable = String.new
	@ProductQuantityAvailable = @ProductQuantityAvailable.to_i
end

if @ProductQuantityAvailableOverride.nil? == true || @ProductQuantityAvailableOverride.empty? == true
	@ProductQuantityAvailableOverride = String.new
	@ProductQuantityAvailableOverride = @ProductQuantityAvailableOverride.to_i
end

if @ProductQuantityAvailable == 0 && @ProductQuantityAvailableOverride != 0
	@ProductQuantityAvailable = @menu["data"]["filteredProducts"]["products"][circles]["manualInventory"][0]["inventory"].to_i
elsif @ProductQuantityAvailable == 0 && @ProductQuantityAvailableOverride == 0
	@ProductQuantityAvailable = 0
else
	@ProductQuantityAvailable = @menu["data"]["filteredProducts"]["products"][circles]["POSMetaData"]["children"][0]["quantityAvailable"]
end

if @ProductStatus == "Active"
	@ProductStatus = true
else
	@ProductStatus = false
end

if @IsSpecial.nil? == true
	@IsSpecial == false
end

puts circles
#puts "#{@ProductID}|#{@ProductBrand}|#{@ProductName}|#{@ProductType}|#{@ProductSubCategory}|#{@ProductImage}|#{@ProductStatus}|#{@IsSpecial}|#{@DispensaryID}".red

insert_query = "INSERT INTO ProductNameBrandType(ProductID, ProductBrand, ProductName, ProductType, ProductTypeSub, ProductImage, ProductStatus, IsSpecial, DispensaryID) VALUES ('#{@ProductID}', '#{@ProductBrand}', '#{@ProductName}', '#{@ProductType}', '#{@ProductSubCategory}', '#{@ProductImage}', #{@ProductStatus}, #{@IsSpecial}, '#{@DispensaryID}');"

DB.execute(insert_query)

while @ProductQuantityOptions.length < 8
@ProductQuantityOptions << nil
end

while @ProductMedicalPrices.length < 8
@ProductMedicalPrices << nil
end

while @ProductMedicalSpecialPrices.length < 8
@ProductMedicalSpecialPrices << nil
end

while @ProductRecPrices.length < 8
@ProductRecPrices << nil
end

while @ProductRecSpecialPrices.length < 8
@ProductRecSpecialPrices << nil
end

#puts @ProductQuantityOptions.join(', ').blue
#puts @ProductMedicalPrices.join(', ').green

#@ProductQuantityOptions.gsub!("N/A", "Unknown")

insert_query = "INSERT INTO MedicalNormalPricing(ProductID, Quantity1, Price1, Quantity2, Price2, Quantity3, Price3, Quantity4, Price4, Quantity5, Price5, Quantity6, Price6, Quantity7, Price7, Quantity8, Price8, InsertionDate, QuantityAvailable, IsSpecial) VALUES ('#{@ProductID}', '#{@ProductQuantityOptions[0]}', '#{@ProductMedicalPrices[0]}', '#{@ProductQuantityOptions[1]}', '#{@ProductMedicalPrices[1]}', '#{@ProductQuantityOptions[2]}', '#{@ProductMedicalPrices[2]}', '#{@ProductQuantityOptions[3]}', '#{@ProductMedicalPrices[3]}', '#{@ProductQuantityOptions[4]}', '#{@ProductMedicalPrices[4]}', '#{@ProductQuantityOptions[5]}', '#{@ProductMedicalPrices[5]}', '#{@ProductQuantityOptions[6]}', '#{@ProductMedicalPrices[6]}', '#{@ProductQuantityOptions[7]}', '#{@ProductMedicalPrices[7]}', DATE(), '#{@ProductQuantityAvailable}', false);"

#puts "Inserting MedicalNormalPricing".yellow
DB.execute(insert_query)

insert_query = "INSERT INTO MedicalSpecialPricing(ProductID, Quantity1, Price1, Quantity2, Price2, Quantity3, Price3, Quantity4, Price4, Quantity5, Price5, Quantity6, Price6, Quantity7, Price7, Quantity8, Price8, InsertionDate, QuantityAvailable, IsSpecial) VALUES ('#{@ProductID}', '#{@ProductQuantityOptions[0]}', '#{@ProductMedicalSpecialPrices[0]}', '#{@ProductQuantityOptions[1]}', '#{@ProductMedicalSpecialPrices[1]}', '#{@ProductQuantityOptions[2]}', '#{@ProductMedicalSpecialPrices[2]}', '#{@ProductQuantityOptions[3]}', '#{@ProductMedicalSpecialPrices[3]}', '#{@ProductQuantityOptions[4]}', '#{@ProductMedicalSpecialPrices[4]}', '#{@ProductQuantityOptions[5]}', '#{@ProductMedicalSpecialPrices[5]}', '#{@ProductQuantityOptions[6]}', '#{@ProductMedicalSpecialPrices[6]}', '#{@ProductQuantityOptions[7]}', '#{@ProductMedicalSpecialPrices[7]}', DATE(), '#{@ProductQuantityAvailable}', true);"

#puts "Inserting MedicalSpecialPricing".blue
DB.execute(insert_query)

end
end