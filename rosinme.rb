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
@are_we_created_thc = 0
@are_we_created_cbd = 0
@which_category = [0 => "products/seeds", 1 => "products/flower", 2 => "products/concentrates", 3 => "products/clones"]
@category_counter = 0
@we_have_reached_the_end = false


@the_key, @ProductBrand, @ProductType, @ProductSubCategory, @ProductName, @loopcounter = String.new

@dispensaries << {:id => "89eEAwyWdNydEBzNE", :name => "Mr. Nice Guy (Portland - SE Woodstock)", :url => "https://dutchie.com/dispensaries/mr-nice-guy-portland-se-woodstock/"}
@dispensaries << {:id => "5e7b9bd0bde0d600980d8982", :name => "Electric Lettuce - Weilder", :url => "https://dutchie.com/dispensaries/electric-lettuce-weidler-st/"}
@dispensaries << {:id => "N8iYxkzdbDMkDo8je", :name => "Homegrown Oregon (Beaverton)", :url => "https://dutchie.com/dispensaries/homegrown-beaverton/"} 
@dispensaries << {:id => "5e7b9c65ff1d7400bedc3145", :name => "Farma", :url => "https://dutchie.com/dispensaries/farma/"}
@dispensaries << {:id => "5e838597f3b57c00c01db92c", :name => "Serra (Downtown Portland)", :url => "https://dutchie.com/dispensaries/serra-downtown-portland/"}
@dispensaries << {:id => "5ee93c37e589a800e305cc8a", :name => "Electric Lettuce - Old Town", :url => "https://dutchie.com/dispensaries/electric-lettuce-old-town/"}
@dispensaries << {:id => "5e6fc7f304402800778626a0", :name => "Bridge City Collective - SE Portland", :url => "https://dutchie.com/dispensaries/bridge-city-collective-se-portland/"}
@dispensaries << {:id => "zFk76cu6yK4swFRiN", :name => "Kaya Shack (Portland)", :url => "https://dutchie.com/dispensaries/kaya-shack-portland/"}
@dispensaries << {:id => "5f971881dd531000d97c650b", :name => "Broadway Cannabis Market", :url => "https://dutchie.com/dispensaries/broadway-cannabis-market/"}
@dispensaries << {:id => "ENWqnaKeFuJQuQ9fH", :name => "Pakalolo (Holgate Blvd)", :url => "https://dutchie.com/dispensaries/pakalolo/"}
@dispensaries << {:id => "fHE6RfjtfNpwKKt5K", :name => "Cannabliss & Co (22nd & Burn)", :url => "https://dutchie.com/dispensaries/cannabliss-and-co-22nd-and-burn/"}
@dispensaries << {:id => "ca5hYarcJmP5Qzqax", :name => "Oregons Finest (Convention Center)", :url => "https://dutchie.com/dispensaries/oregons-finest-convention-center/"}
@dispensaries << {:id => "QBoTaLFJW5EgJxRop", :name => "Oregons Finest (Pearl Dispensary)", :url => "https://dutchie.com/dispensaries/oregons-finest/"}
@dispensaries << {:id => "5e7296f7d0e028008418f81c", :name => "Serra (Belmont St - Portland)", :url => "https://dutchie.com/dispensaries/serra-belmont-or/"}
@dispensaries << {:id => "f3DCDthdTRkPB2SBD", :name => "MindRite", :url => "https://dutchie.com/dispensaries/mindrite/"}
@dispensaries << {:id => "5e7aa0f44f8e0900b7e04a79", :name => "Somewhere PDX", :url => "https://dutchie.com/dispensaries/somewhere-pdx/"}
@dispensaries << {:id => "kHx9t88rZ6awXvAKa", :name => "Papa Buds", :url => "https://dutchie.com/dispensaries/papa-buds/"}
@dispensaries << {:id => "5f6a519a8fb97b0111dc3ae6", :name => "Electric Lettuce - Sellwood", :url => "https://dutchie.com/dispensaries/electric-lettuce-sellwood/"}
@dispensaries << {:id => "5e8cf2cf0b2768009a4ad93e", :name => "Tetra Cannabis (Belmont)", :url => "https://dutchie.com/dispensaries/tetra-cannabis/"}
@dispensaries << {:id => "5ecaf565cb9c1b00e1080b7c", :name => "Pot Mates", :url => "https://dutchie.com/dispensaries/pot-mates/"}
@dispensaries << {:id => "xRfhGAx5zict2K5r3", :name => "Nectar - Beaverton Hillsdale", :url => "https://dutchie.com/dispensaries/nectar-hillsdale/"}
@dispensaries << {:id => "CKQGjaE9GBcsEqcGB", :name => "Nectar - Sandy", :url => "https://dutchie.com/dispensaries/nectar-portland-sandy-blvd/"}
@dispensaries << {:id => "Y5ZmfrHiygRCpTW3A", :name => "La Mota (NW Front)", :url => "https://dutchie.com/dispensaries/la-mota-nw-front/"}
@dispensaries << {:id => "zghKZ9q3dM5YxsnbG", :name => "Nectar - Terwilliger", :url => "https://dutchie.com/dispensaries/nectar-burlingame/"}
@dispensaries << {:id => "TmS5Kcar8tEr8uxfJ", :name => "VIBE - Amberlight", :url => "https://dutchie.com/dispensaries/amberlight-cannabis-house/"}
@dispensaries << {:id => "5e7ba1326e447b60db4fe9bf", :name => "Five Zero Trees - SW Portland", :url => "https://dutchie.com/dispensaries/five-zero-trees-sw-portland/"}
@dispensaries << {:id => "5e7ba01f6e5f2100a7212fae", :name => "Electric Lettuce - Foster - Powell", :url => "https://dutchie.com/dispensaries/electric-lettuce-foster-powell/"}
@dispensaries << {:id => "5e6fc7883f8979007a172c1e", :name => "Bridge City Collective - N WIlliams", :url => "https://dutchie.com/dispensaries/bridge-city-collective/"}
@dispensaries << {:id => "SSexAhLYfSzoLqm9o", :name => "Deanz Greenz (Sandy)", :url => "https://dutchie.com/dispensaries/deanz-greenz-sandy/"}
@dispensaries << {:id => "89eEAwyWdNydEBzNE", :name => "La Mota (Hollywood)", :url => "https://dutchie.com/dispensaries/la-mota-hollywood/"}
@dispensaries << {:id => "r9X4EhpBEzkhG7MGC", :name => "La Mota (Johnson Creek)", :url => "https://dutchie.com/dispensaries/la-mota-johnson-creek/"}
@dispensaries << {:id => "5e837decde402e00a87a0c32", :name => "Electric Lettuce - Alberta Arts District", :url => "https://dutchie.com/dispensaries/electric-lettuce-alberta/"}
@dispensaries << {:id => "ZMaB6fPzHSfFqWngG", :name => "La Mota (SE Portland)", :url => "https://dutchie.com/dispensaries/la-mota-se-portland/"}
@dispensaries << {:id => "ze8wN7pb8Y2M9cP5B", :name => "The New Amsterdam", :url => "https://dutchie.com/dispensaries/the-new-amsterdam/"}
#@dispensaries << {:id => "5e7b9faa4d6325009a878672", :name => "Foster Buds - NE Glisan St", :url => "https://dutchie.com/dispensaries/foster-buds-glisan-st/"}
@dispensaries << {:id => "5e7ba1aaed7b5400afa9c7f0", :name => "Five Zero Trees - Dekum St", :url => "https://dutchie.com/dispensaries/five-zero-trees-dekum-st/"}
@dispensaries << {:id => "5e6be93acdc3af00712fe275", :name => "The People's Dispensary (Portland)", :url => "https://dutchie.com/dispensaries/peoples-dispensary-portland/"}
@dispensaries << {:id => "5fa5d4a1e7895000ece0b666", :name => "Top Hat Express", :url => "https://dutchie.com/dispensaries/top-hat-express1/"}
@dispensaries << {:id => "5e7b8dfe49f75e00bbdb7b9e", :name => "Electric Lettuce - Cedar Hills", :url => "https://dutchie.com/dispensaries/electric-lettuce-marlow-ave/"}
@dispensaries << {:id => "5eb33c2258a5f300e86f6ac5", :name => "Five Zero Trees (East Portland)", :url => "https://dutchie.com/dispensaries/five-zero-trees-east-portland/"}
@dispensaries << {:id => "cgooXmKenGs48qvZf", :name => "Chalice Farms (Downtown)", :url => "https://dutchie.com/dispensaries/chalice-farms-downtown/"}
@dispensaries << {:id => "GbjYW7MF3mBtNogmk", :name => "Cannabliss (Firestation 23)", :url => "https://dutchie.com/dispensaries/cannabliss-and-co-firestation-23/"}
@dispensaries << {:id => "5e7c0b6dd4bcd700b4a3be73", :name => "Truly Pure", :url => "https://dutchie.com/dispensaries/truly-pure1/"}
@dispensaries << {:id => "kgtGfbPx92Z2zMb8X", :name => "Diem Delivery", :url => "https://dutchie.com/dispensaries/diem-portland/"}
@dispensaries << {:id => "gM9rZFpEyZWL36B6R", :name => "Attis Trading Co (Gladstone)", :url => "https://dutchie.com/dispensaries/attis-trading-co-gladstone/"}
@dispensaries << {:id => "DCernomKcb4hPQgW9", :name => "Attis Trading Co (Barbur)", :url => "https://dutchie.com/dispensaries/attis-trading-co-barbur/"}
@dispensaries << {:id => "FeADLqAA74sqwWuNb", :name => "TJs on Powell", :url => "https://dutchie.com/dispensaries/tjs-on-powell/"}
@dispensaries << {:id => "zaszMhfCbuLdD3Dpb", :name => "Cannabliss Co (The Blvd)", :url => "https://dutchie.com/dispensaries/cannabliss-and-co-the-blvd/"}
@dispensaries << {:id => "Yn3jEf88Eqa3APASZ", :name => "Deanz Greenz (Foster)", :url => "https://dutchie.com/dispensaries/deanz-greenz-foster/"}
@dispensaries << {:id => "mrRCfw9orrg6ZPQWK", :name => "Left Coast Connection", :url => "https://dutchie.com/dispensaries/left-coast-connection/"}
@dispensaries << {:id => "5ea22aff790b8f00dd98f598", :name => "SWED CO", :url => "https://dutchie.com/dispensaries/swedco/"}
@dispensaries << {:id => "zBKaBM3hTpspDwMED", :name => "Natural RXemedies", :url => "https://dutchie.com/dispensaries/natural-remedies/"}
@dispensaries << {:id => "D8RQfZ6Kftnxeof2P", :name => "Oregrown (Portland)", :url => "https://dutchie.com/dispensaries/oregrown-portland/"}
@dispensaries << {:id => "zKjLfByt2tvgmiQvt", :name => "Chalice Farms (Powell)", :url => "https://dutchie.com/dispensaries/chalice-farms-powell/"}
@dispensaries << {:id => "5NFnoMgMWbTrT6Ftb", :name => "Urban Farmacy", :url => "https://dutchie.com/dispensaries/urban-farmacy/"}
@dispensaries << {:id => "60a44a64a8d25500d8ddf30e", :name => "Archive", :url => "https://dutchie.com/dispensaries/archive-dispensary/"}
@dispensaries << {:id => "5e790d64ebd56000a2232670", :name => "The Dispensary on 52nd", :url => "https://dutchie.com/dispensaries/the-dispensary-on-52nd/"}
@dispensaries << {:id => "5fd14af4568b4a00c085c55a", :name => "Curaleaf (OR) - Portland", :url => "https://dutchie.com/dispensaries/curaleaf-portland/"}
@dispensaries << {:id => "6058fc09a48ce600e39d3ea4", :name => "Arcanna", :url => "https://dutchie.com/dispensaries/arcanna1/"}
@dispensaries << {:id => "zhe4RsuA8HeFyBTEJ", :name => "Mongoose Cannabis Co.", :url => "https://dutchie.com/dispensaries/mongoose-cannabis/"}
@dispensaries << {:id => "60dcdb5bea379000a7a73d0d", :name => "Rose Budz PDX", :url => "https://dutchie.com/dispensaries/rosebud-pdx/"}
@dispensaries << {:id => "SbnMPug4uHJZu5tG3", :name => "Oregrown (Bend)", :url => "https://dutchie.com/dispensaries/oregrown/"} #Bend
@dispensaries << {:id => "Qrd75dsXJoyDKk5N2", :name => "CannaVida (Bend)", :url => "https://dutchie.com/dispensaries/cannavida/"} #Bend
@dispensaries << {:id => "LS66XHqeBcc2evj7m", :name => "Substance (Division Street) (Bend)", :url => "https://dutchie.com/dispensaries/substance-division/"} #Bend
@dispensaries << {:id => "wiPzqSXJvgE6d9eTC", :name => "Mr. Nice Guy (Bend)", :url => "https://dutchie.com/dispensaries/mr-nice-guy-bend/"} #Bend
@dispensaries << {:id => "5f6cd5227fc9eb00e61861d6", :name => "Top Shelf Medicine (Bend)", :url => "https://dutchie.com/dispensaries/top-shelf-medicine-bend/"} #Bend
@dispensaries << {:id => "2h6ho6sgw8tz8R6FQ", :name => "Fyre (Bend)", :url => "https://dutchie.com/dispensaries/Fyre/"} #Bend
@dispensaries << {:id => "5e73fb4fc33c1b006bdab6cc", :name => "Tokyo Starfish (South)", :url => "https://dutchie.com/dispensaries/tokyo-starfish-south/"} #Bend
@dispensaries << {:id => "XakCpASMTpXZSwruB", :name => "DiamondTREE West (Bend)", :url => "https://dutchie.com/dispensaries/diamondtree-west/"} #Bend
@dispensaries << {:id => "A9rxwr3podA5vMFJK", :name => "Dr. Jolly's (Bend)", :url => "https://dutchie.com/dispensaries/dr-jollys/"} #Bend
@dispensaries << {:id => "ayvhGbpbZByWWWYmW", :name => "Substance (South 97)", :url => "https://dutchie.com/dispensaries/substance-3rd-st/"} #Bend
@dispensaries << {:id => "3WjnYqqC9wjQFpBFX", :name => "Substance (Empire Ave.)", :url => "https://dutchie.com/dispensaries/substance-empire/"} #Bend
@dispensaries << {:id => "w5rAz2WPTWdZbcDod", :name => "Oregon Euphorics", :url => "https://dutchie.com/dispensaries/oregon-euphorics/"} #Bend
@dispensaries << {:id => "mAnBErqynt3tz77uA", :name => "The Vth LMNT - Bend", :url => "https://dutchie.com/dispensaries/the-vth-lmnt/"} #Bend



DB = SQLite3::Database.open("dutchie_test1.db")

def menu_dump(caneme)

@response = HTTParty.get(@the_key)
sleep(10)
@menu = JSON.parse(@response.body)

end

def sacrificial_lamb()

@browser = Watir::Browser.new :chrome, headless: true
puts "Opened Browser!"#.green

end

def have_we_reached_the_end()

@we_have_reached_the_end = @browser.text.include?('any products that match your search. Try again!')

end


def open_the_gates(caneme, which_category)
puts caneme[:url] + which_category
@browser.goto(caneme[:url] + which_category)
sleep(5)
#@browser.refresh
#sleep(10)
script = 'var performance = window.performance || window.mozPerformance || window.msPerformance || window.webkitPerformance || {}; return performance.getEntries().filter(e=>e.initiatorType=="fetch")'
stripper = @browser.execute_script(script)
#puts stripper
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

for z in 0..(@which_category[0].count - 1)
open_the_gates(caneme, @which_category[0][z])


menu_dump(caneme)

@loopcounter = @menu["data"]["filteredProducts"]["products"]
puts @loopcounter.count
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
@ProductTHCContent = @menu["data"]["filteredProducts"]["products"][circles]["THCContent"]
@ProductCBDContent = @menu["data"]["filteredProducts"]["products"][circles]["CBDContent"]

#puts @ProductTHCContent
#puts @ProductCBDContent

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


if @ProductTHCContent.nil? == true || @ProductTHCContent.empty? == true
	@ProductTHCContent = Array.new
	@ProductTHCContent = {"unit" => "N/A", "range" => [0,0]}
end
if @ProductCBDContent.nil? == true || @ProductCBDContent.empty? == true
	@ProductCBDContent = Array.new
	@ProductCBDContent = {"unit" => "N/A", "range" => [0,0]}
end
#pry
if 	@ProductTHCContent['range'].nil? == true || @ProductTHCContent['range'].empty? == true
	@ProductTHCContent['range'] = [0]
end
if @ProductCBDContent['range'].nil? == true || @ProductCBDContent['range'].empty? == true
	@ProductCBDContent['range'] = [0]
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

insert_query = "INSERT INTO MedicalNormalPricing(ProductID, Quantity1, Price1, Quantity2, Price2, Quantity3, Price3, Quantity4, Price4, Quantity5, Price5, Quantity6, Price6, Quantity7, Price7, Quantity8, Price8, InsertionDate, QuantityAvailable, IsSpecial) VALUES ('#{@ProductID}', '#{@ProductQuantityOptions[0]}', '#{@ProductMedicalPrices[0].to_f}', '#{@ProductQuantityOptions[1]}', '#{@ProductMedicalPrices[1].to_f}', '#{@ProductQuantityOptions[2]}', '#{@ProductMedicalPrices[2].to_f}', '#{@ProductQuantityOptions[3]}', '#{@ProductMedicalPrices[3].to_f}', '#{@ProductQuantityOptions[4]}', '#{@ProductMedicalPrices[4].to_f}', '#{@ProductQuantityOptions[5]}', '#{@ProductMedicalPrices[5].to_f}', '#{@ProductQuantityOptions[6]}', '#{@ProductMedicalPrices[6].to_f}', '#{@ProductQuantityOptions[7]}', '#{@ProductMedicalPrices[7].to_f}', DATE(), '#{@ProductQuantityAvailable}', false);"

#puts "Inserting MedicalNormalPricing".yellow
DB.execute(insert_query)

insert_query = "INSERT INTO MedicalSpecialPricing(ProductID, Quantity1, Price1, Quantity2, Price2, Quantity3, Price3, Quantity4, Price4, Quantity5, Price5, Quantity6, Price6, Quantity7, Price7, Quantity8, Price8, InsertionDate, QuantityAvailable, IsSpecial) VALUES ('#{@ProductID}', '#{@ProductQuantityOptions[0]}', '#{@ProductMedicalSpecialPrices[0].to_f}', '#{@ProductQuantityOptions[1]}', '#{@ProductMedicalSpecialPrices[1].to_f}', '#{@ProductQuantityOptions[2]}', '#{@ProductMedicalSpecialPrices[2].to_f}', '#{@ProductQuantityOptions[3]}', '#{@ProductMedicalSpecialPrices[3].to_f}', '#{@ProductQuantityOptions[4]}', '#{@ProductMedicalSpecialPrices[4].to_f}', '#{@ProductQuantityOptions[5]}', '#{@ProductMedicalSpecialPrices[5].to_f}', '#{@ProductQuantityOptions[6]}', '#{@ProductMedicalSpecialPrices[6].to_f}', '#{@ProductQuantityOptions[7]}', '#{@ProductMedicalSpecialPrices[7].to_f}', DATE(), '#{@ProductQuantityAvailable}', true);"

#puts "Inserting MedicalSpecialPricing".blue
DB.execute(insert_query)
#pry
insert_query = "INSERT INTO ProductCannabinoidsContent(ProductID, ProductTHCUnit, ProductTHCAmount, ProductCBDUnit, ProductCBDAmount) VALUES ('#{@ProductID}', '#{@ProductTHCContent['unit']}', '#{@ProductTHCContent['range'].last}', '#{@ProductCBDContent['unit']}', '#{@ProductCBDContent['range'].last}');"
#

#puts insert_query
DB.execute(insert_query)

end

end

end