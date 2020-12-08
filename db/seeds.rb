# Create a admin user.
User.create!(fullname: "tham",
	email: "nttham98@gmail.com",
	password: "123456",
	password_confirmation: "123456", 
	admin: true)

# Create users.
10.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@gmail.com"
	password = "password"
	User.create!(fullname: name,
		email: email,
		password: password,
		password_confirmation: password)
end

# Create products.
10.times do |n|
	name = "ao 1234"
	product_type = 1
	classify = 1
	Product.create!(name: name,
		product_type: product_type,
		classify: classify)
end


