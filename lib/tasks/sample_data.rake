namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
  end
end


def make_users
  admin = User.create!(name:     "Amina Bouabdallah",
                       email:    "amina@gmail.com",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  
    User.create!(name:     "Nabil Bouabdallah",
                 email:    "nabil@gmail.com",
                 password: "foobar",
                 password_confirmation: "foobar")
	
	User.create!(name:     "Nawel Bouabdallah",
                 email:    "nawel@gmail.com",
                 password: "foobar",
                 password_confirmation: "foobar")
  end


def make_microposts
  users = User.all
  users.each { |user| user.microposts.create!(content: "Glad I joined", start_town: "Compiegne", start_location: "Mairie", drop_town: "Paris", drop_location: "Mairie", date: "12 mars 2012", nb_passengers: "4") }
  end
end


def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[1..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end
