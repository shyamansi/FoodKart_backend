# #write valid password method which does not natch with email address and password should not more than 40% of email 
# def valid_password(password,email)
#     p password.empty?
#     return false if password.empty?
#     p password
#     p email 
#     return false if password == email
#     email1 = email.split('@').first
#     p email1
#     p email1.length * 0.4
#     return false if password.length > (email1.length * 0.4)
    
#     return true
# end

# p valid_password("password123", "shyam@gmail.com")