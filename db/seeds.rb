role_admin = Role.create({:name=>'admin'})
user_admin = User.create({:login=>'admin',
                          :password=>'12345',:password_confirmation=>'12345',
                          :email=>'admin@admin.com',:role_ids=>[1]})

