# # db/seeds.rb
# require "open-uri"
# require "unsplash"
# require "ostruct"
# puts "Seeding starts now..."
# # --------------------------------
# # Configure Unsplash
# # --------------------------------
# Unsplash.configure do |config|
#   config.application_access_key = Rails.application.credentials.dig(:unsplash, :access_key)
#   config.application_secret     = Rails.application.credentials.dig(:unsplash, :secret_key)
#   config.utm_source             = "depot_app"
# end
# # --------------------------------
# # Bike Data
# # --------------------------------
# honda_bikes = [
#   { title: "Honda CBR900RR Fireblade 1992", price: 8999.00, description: "The 1992 Honda CBR900RR Fireblade revolutionized sportbikes with its lightweight frame and powerful engine." },
#   { title: "Honda VFR750R RC30 1988", price: 14999.00, description: "The Honda VFR750R RC30 was a homologation special designed for racing with its V4 engine and race-tuned components." },
#   { title: "Honda CB750 Four 1969", price: 12999.00, description: "The Honda CB750 Four is often called the first superbike, introducing an inline-four engine with front disc brakes." },
#   { title: "Honda CBR600F 1989", price: 6999.00, description: "The Honda CBR600F combined everyday usability with track performance, setting the tone for middleweight sportbikes." },
#   { title: "Honda NR750 1992", price: 24999.00, description: "The Honda NR750 featured oval pistons, an innovative design that made it one of the rarest and most exotic motorcycles ever built." }
# ]
# suzuki_bikes = [
#   { title: "Suzuki GSX-R750 1985", price: 7999.00, description: "The Suzuki GSX-R750 pioneered the race-replica sportbike category with lightweight construction and high power." },
#   { title: "Suzuki Hayabusa GSX1300R 1999", price: 10999.00, description: "The Suzuki Hayabusa became the world’s fastest production motorcycle at the time, exceeding 300 km/h." },
#   { title: "Suzuki RG500 Gamma 1985", price: 13999.00, description: "The Suzuki RG500 Gamma was a two-stroke racing legend made available for the road." },
#   { title: "Suzuki Katana GSX1100S 1981", price: 8999.00, description: "The Suzuki Katana shocked the world with its radical design and high performance." },
#   { title: "Suzuki GSX-R1000 K5 2005", price: 9999.00, description: "The 2005 Suzuki GSX-R1000 K5 was praised for its perfect balance of power, weight, and handling." }
# ]
# yamaha_bikes = [
#   { title: "Yamaha YZF-R1 1998", price: 10999.00, description: "The Yamaha YZF-R1 redefined the liter-class sportbike with its compact engine and chassis design." },
#   { title: "Yamaha RD350LC 1980", price: 7999.00, description: "The Yamaha RD350LC was a two-stroke legend, popular among enthusiasts for its speed and agility." },
#   { title: "Yamaha VMAX 1985", price: 9999.00, description: "The Yamaha VMAX introduced the world to the V4 power cruiser with unmatched straight-line performance." },
#   { title: "Yamaha FZR1000 EXUP 1989", price: 8999.00, description: "The Yamaha FZR1000 EXUP featured an exhaust valve system for improved performance across the rev range." },
#   { title: "Yamaha TZR250 1986", price: 8499.00, description: "The Yamaha TZR250 was a two-stroke race replica beloved by riders for its sharp handling and speed." }
# ]
# kawasaki_bikes = [
#   { title: "Kawasaki Ninja ZX-10R 2004", price: 10999.00, description: "The Kawasaki Ninja ZX-10R debuted as one of the most powerful and aggressive liter-class sportbikes." },
#   { title: "Kawasaki GPZ900R Ninja 1984", price: 8999.00, description: "The Kawasaki GPZ900R was the first motorcycle to be called 'Ninja' and starred in the movie Top Gun." },
#   { title: "Kawasaki Z1 900 1972", price: 14999.00, description: "The Kawasaki Z1 900 was Kawasaki’s first superbike, challenging Honda’s CB750 with even more power." },
#   { title: "Kawasaki KR500 1980", price: 19999.00, description: "The Kawasaki KR500 was a rare square-four race bike, produced in very limited numbers." },
#   { title: "Kawasaki H2 Mach IV 1972", price: 12999.00, description: "The Kawasaki H2 Mach IV was a two-stroke triple that earned the nickname 'Widowmaker' due to its power." }
# ]
# ducati_bikes = [
#   { title: "Ducati 916 1994", price: 16999.00, description: "The Ducati 916 is regarded as one of the most beautiful motorcycles ever, combining design and performance." },
#   { title: "Ducati Monster 900 1993", price: 8999.00, description: "The Ducati Monster 900 created the naked bike category with its minimalist design." },
#   { title: "Ducati Desmosedici RR 2007", price: 24999.00, description: "The Ducati Desmosedici RR was a MotoGP replica made available to the public." },
#   { title: "Ducati 851 1987", price: 13999.00, description: "The Ducati 851 introduced liquid cooling and fuel injection, leading Ducati into the modern superbike era." },
#   { title: "Ducati Paul Smart 1000 LE 2006", price: 14999.00, description: "The Ducati Paul Smart 1000 LE was a retro-styled limited edition, honoring Ducati’s racing heritage." }
# ]
# all_bikes = honda_bikes + suzuki_bikes + yamaha_bikes + kawasaki_bikes + ducati_bikes
# # --------------------------------
# # Seeding Products
# # --------------------------------
# all_bikes.each do |bike|
#   product = Product.create!(
#     title: bike[:title],
#     price: bike[:price],
#     description: bike[:description]
#   )
#   begin
#     # --------------------------------
#     # 1. Search for bike image on Unsplash
#     # --------------------------------
#     results = Unsplash::Photo.search(bike[:title])
#     if results.any?
#       url = results.first.urls.full
#       puts "✅ Found Unsplash image for #{bike[:title]}: #{url}"
#     else
#       # --------------------------------
#       # 2. Fallback: Cat picture
#       # --------------------------------
#       cat_results = Unsplash::Photo.search("cat")
#       if cat_results.any?
#         url = cat_results.sample.urls.full
#         puts "😺 No bike image for #{bike[:title]}, using cat image: #{url}"
#       else
#         puts "⚠️ No fallback image found. Skipping image for #{bike[:title]}"
#         next
#       end
#     end
#     # --------------------------------
#     # 3. Attach image via Active Storage
#     # --------------------------------
#     puts "📥 Downloading image from #{url}..."
#     file = URI.open(url)
#     product.image.attach(
#       io: file,
#       filename: "#{bike[:title].parameterize}.jpg",
#       content_type: "image/jpeg"
#     )
#     puts "💾 Image attached: #{product.image.attached?}"
#     puts "💾 Attached image to #{product.title}"
#   rescue => e
#     puts "❌ Failed to attach image for #{bike[:title]}: #{e.message}"
#   end
#   puts "Created product: #{product.title}"
# end
# puts "Seeding completed!"


# db/seeds.rb

Product.delete_all

Product.create!(
  title: 'Build Chatbots with Ruby',
  description:
    %(<p>
      <em>Supercharge your Ruby apps</em>
      Learn how to use Ruby and the Rails framework to build interactive chatbots.
      Covers APIs, NLP basics, and integration techniques.
    </p>),
  image_url: 'ruby_chatbots.jpeg',
  price: 49.95
)

Product.create!(
  title: 'Programming Ruby 3.2',
  description:
    %(<p>
      <em>The Pragmatic Programmer’s Guide</em>
      The definitive reference for Ruby programmers.
      Updated for Ruby 3.2, this book covers syntax, built-in classes, and advanced topics.
    </p>),
  image_url: 'ruby_book.jpeg',
  price: 59.95
)

Product.create!(
  title: 'Agile Web Development with Rails 8',
  description:
    %(<p>
      <em>Rails 8 Edition</em>
      A complete guide to developing web applications using Ruby on Rails 8.
      Walk through every step of building a real app — from idea to deployment.
    </p>),
  image_url: 'rails_book.jpeg',
  price: 42.00
)
