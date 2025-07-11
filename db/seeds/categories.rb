puts "Creating categories..."
Category.delete_all

CATEGORIES = [
  { name: "Máy lạnh", logo: "https://cdnv2.tgdd.vn/mwg-static/common/Common/48/a6/48a6bd2b6d7ad2712eb93772b3578deb.png", order_by: 1 },
  { name: "Tủ lạnh", logo: "https://cdnv2.tgdd.vn/mwg-static/common/Common/64/85/6485154d19085e781f44d057f1c63c71.png", order_by: 2 },
  { name: "Quạt điều hòa", logo: "https://cdnv2.tgdd.vn/mwg-static/dmx/Common/c9/c2/c9c2dde6917220170feebf1d9bdff8da.png", order_by: 3 },
  { name: "Gia dụng", logo: "https://cdnv2.tgdd.vn/mwg-static/dmx/Common/8c/1b/8c1b71a6a8fc062456825e6483b26e6b.png", order_by: 4 },
  { name: "Máy giặt", logo: "https://cdnv2.tgdd.vn/mwg-static/common/Common/0a/b9/0ab938f5b5b2993d568351bceb721407.png", order_by: 5 },
  { name: "Tivi", logo: "https://cdnv2.tgdd.vn/mwg-static/common/Common/64/d1/64d11a09c75ea322dbc547739886e1d5.png", order_by: 6 },
  { name: "Máy lọc nước", logo: "https://cdnv2.tgdd.vn/mwg-static/common/Common/ff/40/ff40b05375a001ea1f246cfd81fcbd12.png", order_by: 7 },
  { name: "Quạt", logo: "https://cdnv2.tgdd.vn/mwg-static/dmx/Common/bc/d4/bcd447fedb2efb22c4060f133cc5498e.png", order_by: 8 },
  { name: "Tủ đông mát", logo: "https://cdnv2.tgdd.vn/mwg-static/dmx/Common/5f/fc/5ffc124606fecac8c77bceb28b9c5c05.png", order_by: 9 },
  { name: "Máy sấy quần áo", logo: "https://cdnv2.tgdd.vn/mwg-static/dmx/Common/0c/c3/0cc360b738e93b746af289ba67029e57.png", order_by: 10 },
  { name: "Nồi cơm điện", logo: "https://cdnv2.tgdd.vn/mwg-static/dmx/Common/2a/8c/2a8ca60d0f63068060068e3884032499.png", order_by: 11 },
  { name: "Hút bụi", logo: "https://cdnv2.tgdd.vn/mwg-static/dmx/Common/ad/d4/add43c28ca2de72ffdef6c59b19bf7a7.png", order_by: 12 },
  { name: "Máy nước nóng", logo: "https://cdnv2.tgdd.vn/mwg-static/dmx/Common/e5/94/e594135d5eed6cc128fe2a9c62154ad9.png", order_by: 13 },
  { name: "Loa", logo: "https://cdnv2.tgdd.vn/mwg-static/common/Common/00/55/0055c858a83557e51e539deedda6dd81.png", order_by: 14 },
  { name: "Sức khoẻ, Làm đẹp", logo: "https://cdnv2.tgdd.vn/mwg-static/dmx/Common/f1/d1/f1d12948bb2b74c2175f2eb29449f477.png", order_by: 15 }
]

CATEGORIES.each do |category|
  Category.find_or_create_by!(name: category[:name]) do |c|
    c.slug = category[:name].to_slug
    c.logo = category[:logo]
    c.order_by = category[:order_by]
  end
end

puts "✅ Categories seeded!"
