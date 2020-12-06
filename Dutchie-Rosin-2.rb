require 'wannabe_bool'
require 'httparty'
require 'sqlite3'
require 'json'
require 'colorize'
require 'pry'

#Insert a check to remove Accessories and other such nonsense to reduce on databsae size and insertion time. Current runtime is 3.5+hours.
#Create INSERT for THC/CBD content linked via ProductID in a different able. Or perhaps in a productID table itself, with a new schema?
#Categories to remove:
#Accessories
#Apparel
#Topicals
#Edibles
#Pre-Rolls


@dispensaries = []

@ProductBrand, @ProductType, @ProductSubCategory, @ProductName = String.new

@dispensaries << {:id => "89eEAwyWdNydEBzNE", :name => "Mr. Nice Guy (Portland - SE Woodstock)"}
@dispensaries << {:id => "5e7b9bd0bde0d600980d8982", :name => "Electric Lettuce - Weilder"}
@dispensaries << {:id => "N8iYxkzdbDMkDo8je", :name => "Homegrown Oregon (Beaverton)"} 
@dispensaries << {:id => "5e7b9c65ff1d7400bedc3145", :name => "Farma"}
@dispensaries << {:id => "5e838597f3b57c00c01db92c", :name => "Serra (Downtown Portland)"}
@dispensaries << {:id => "5ee93c37e589a800e305cc8a", :name => "Electric Lettuce - Old Town"}
@dispensaries << {:id => "5e6fc7f304402800778626a0", :name => "Bridge City Collective - SE Portland"}
@dispensaries << {:id => "zFk76cu6yK4swFRiN", :name => "Kaya Shack (Portland)"}
@dispensaries << {:id => "5f971881dd531000d97c650b", :name => "Broadway Cannabis Market"}
@dispensaries << {:id => "ENWqnaKeFuJQuQ9fH", :name => "Pakalolo (Holgate Blvd)"}
@dispensaries << {:id => "fHE6RfjtfNpwKKt5K", :name => "Cannabliss & Co (22nd & Burn)"}
@dispensaries << {:id => "ca5hYarcJmP5Qzqax", :name => "Oregons Finest (Convention Center)"}
@dispensaries << {:id => "QBoTaLFJW5EgJxRop", :name => "Oregons Finest (Pearl Dispensary)"}
@dispensaries << {:id => "5e7296f7d0e028008418f81c", :name => "Serra (Belmont St - Portland)"}
@dispensaries << {:id => "f3DCDthdTRkPB2SBD", :name => "MindRite"}
@dispensaries << {:id => "5e7aa0f44f8e0900b7e04a79", :name => "Somewhere PDX"}
@dispensaries << {:id => "kHx9t88rZ6awXvAKa", :name => "Papa Buds"}
@dispensaries << {:id => "5f6a519a8fb97b0111dc3ae6", :name => "Electric Lettuce - Sellwood"}
@dispensaries << {:id => "5e8cf2cf0b2768009a4ad93e", :name => "Tetra Cannabis (Belmont)"}
@dispensaries << {:id => "5ecaf565cb9c1b00e1080b7c", :name => "Pot Mates"}
@dispensaries << {:id => "xRfhGAx5zict2K5r3", :name => "Nectar - Beaverton Hillsdale"}
@dispensaries << {:id => "CKQGjaE9GBcsEqcGB", :name => "Nectar - Sandy"}
@dispensaries << {:id => "Y5ZmfrHiygRCpTW3A", :name => "La Mota (NW Front)"}
@dispensaries << {:id => "zghKZ9q3dM5YxsnbG", :name => "Nectar - Terwilliger"}
@dispensaries << {:id => "TmS5Kcar8tEr8uxfJ", :name => "VIBE - Amberlight"}
@dispensaries << {:id => "5e7ba1326e447b60db4fe9bf", :name => "Five Zero Trees - SW Portland"}
@dispensaries << {:id => "5e7ba01f6e5f2100a7212fae", :name => "Electric Lettuce - Foster - Powell"}
@dispensaries << {:id => "5e6fc7883f8979007a172c1e", :name => "Bridge City Collective - N WIlliams"}
@dispensaries << {:id => "89eEAwyWdNydEBzNE", :name => "La Mota (Hollywood)"}
@dispensaries << {:id => "r9X4EhpBEzkhG7MGC", :name => "La Mota (Johnson Creek)"}
@dispensaries << {:id => "5e837decde402e00a87a0c32", :name => "Electric Lettuce - Alberta Arts District"}
@dispensaries << {:id => "ZMaB6fPzHSfFqWngG", :name => "La Mota (SE Portland)"}
@dispensaries << {:id => "ze8wN7pb8Y2M9cP5B", :name => "The New Amsterdam"}
@dispensaries << {:id => "5e7b9faa4d6325009a878672", :name => "Foster Buds - NE Glisan St"}
@dispensaries << {:id => "5e7ba1aaed7b5400afa9c7f0", :name => "Five Zero Trees - Dekum St"}
@dispensaries << {:id => "5e6be93acdc3af00712fe275", :name => "The People's Dispensary (Portland)"}
@dispensaries << {:id => "5fa5d4a1e7895000ece0b666", :name => "Top Hat Express"}
@dispensaries << {:id => "5e7b8dfe49f75e00bbdb7b9e", :name => "Electric Lettuce - Cedar Hills"}
@dispensaries << {:id => "5eb33c2258a5f300e86f6ac5", :name => "Five Zero Trees (East Portland)"}
@dispensaries << {:id => "cgooXmKenGs48qvZf", :name => "Chalice Farms (Downtown)"}
@dispensaries << {:id => "GbjYW7MF3mBtNogmk", :name => "Cannabliss (Firestation 23)"}
@dispensaries << {:id => "5e7c0b6dd4bcd700b4a3be73", :name => "Truly Pure"}
@dispensaries << {:id => "kgtGfbPx92Z2zMb8X", :name => "Diem Delivery"}
@dispensaries << {:id => "gM9rZFpEyZWL36B6R", :name => "Attis Trading Co (Gladstone)"}
@dispensaries << {:id => "DCernomKcb4hPQgW9", :name => "Attis Trading Co (Barbur)"}
@dispensaries << {:id => "FeADLqAA74sqwWuNb", :name => "TJs on Powell"}
@dispensaries << {:id => "zaszMhfCbuLdD3Dpb", :name => "Cannabliss Co (The Blvd)"}
@dispensaries << {:id => "Yn3jEf88Eqa3APASZ", :name => "Deanz Greenz (Foster)"}
@dispensaries << {:id => "mrRCfw9orrg6ZPQWK", :name => "Left Coast Connection"}
@dispensaries << {:id => "5ea22aff790b8f00dd98f598", :name => "SWED CO"}
@dispensaries << {:id => "zBKaBM3hTpspDwMED", :name => "Natural RXemedies"}
@dispensaries << {:id => "D8RQfZ6Kftnxeof2P", :name => "Oregrown (Portland)"}
@dispensaries << {:id => "zKjLfByt2tvgmiQvt", :name => "Chalice Farms (Powell)"}
@dispensaries << {:id => "5NFnoMgMWbTrT6Ftb", :name => "Urban Farmacy"}
@dispensaries << {:id => "SSexAhLYfSzoLqm9o", :name => "Deanz Greenz (Sandy)"}

DB = SQLite3::Database.open("dutchie_test1.db")

def menu_dump(caneme)

insertme = caneme[:id]

@response = HTTParty.get("https://dutchie.com/graphql?operationName=FilteredProducts&variables=%7B%22productsFilter%22%3A%7B%22dispensaryId%22%3A%22#{insertme}%22%2C%22bypassOnlineThresholds%22%3Atrue%7D%2C%22useCache%22%3Afalse%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%2246b6131de498686f0c141dd0917f79353439f02e96d7442172ae374c36280052%22%7D%7D")
@menu = JSON.parse(@response.body)

end

def sanitizemecaptain(crush)
#puts crush
if crush.nil? != true && crush.include?("'")
#puts "Not Nil - Brand".green
	crush.gsub!("'", "")
#puts crush
end
end

@dispensaries.each do |caneme|

menu_dump(caneme)

@loopcounter = @menu["data"]["filteredProducts"]["products"].count
puts caneme[:name]

for circles in 0..@loopcounter-1

@ProductBrand = @menu["data"]["filteredProducts"]["products"][circles]["brandName"]
@DispensaryID = @menu["data"]["filteredProducts"]["products"][circles]["DispensaryID"]
@ProductID = @menu["data"]["filteredProducts"]["products"][circles]["id"]
@ProductImage = @menu["data"]["filteredProducts"]["products"][circles]["Image"]
@ProductType = @menu["data"]["filteredProducts"]["products"][circles]["type"]
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
sanitizemecaptain(@ProductType)

#if circles == 8
#pry
#end

if @ProductQuantityAvailable.nil? == true || @ProductQuantityAvailable.empty? == true
	@ProductQuantityAvailable = String.new
	@ProductQuantityAvailable = @ProductQuantityAvailable.to_i
end

if @ProductQuantityAvailableOverride.nil? == true || @ProductQuantityAvailableOverride.empty? == true
	@ProductQuantityAvailableOverride = String.new
	@ProductQuantityAvailableOverride = @ProductQuantityAvailableOverride.to_i
end

#if circles == 8
#pry
#end

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
sleep(15)
end