
#####################################################################################################################

require 'io/console'
require 'pry'
require_relative "contact"
require_relative "misc"

#####################################################################################################################



#####################################################################################################################


class CRM

	def clear_screen

		puts "\e[H\e[2J"
		puts ""
		puts ""
		puts "     CCCCCCCCC     RRRRRRRRRRRR       MM            MM    "
		puts "     CCCCCCCCC     RRRRRRRRRRRR       MM MM      MM MM	"
		puts "     CC            RR        RR       MM  MM    MM  MM	"
		puts "     CC            RR        RR       MM   MM  MM   MM	"
		puts "     CC            RR        RR       MM     MM     MM	"
		puts "     CC            RR        RR       MM            MM	"	
		puts "     CC            RRRRRRRRRRRR       MM            MM	"	
		puts "     CC            RRRRRR             MM            MM	"
		puts "     CC            RR  RR             MM            MM	"
		puts "     CC            RR    RR           MM            MM	"
		puts "     CCCCCCCCC     RR      RR         MM            MM	"
		puts "     CCCCCCCCC     RR        RR       MM            MM	"
		puts "\n\n	"
			

		puts "                       BAD BADGE CRM                   "
		puts "     .............     VERSION:  2.0     .............."
		puts "     .........         Avinash  Jham        ..........."
		puts " \n"
	end # ............................................................................................................
	
	def display_menu(menu)  # E.g. ["1","2","3","4","5","6"]

		valid_options = []

		clear_screen	
		menu.each do | k,v| 
			puts " Press [ #{k} ] to  #{v}  "
			valid_options.push(k.to_s)
		end

		print "\n Select a valid option: "

		while true
			#option = gets.chomp.to_i
			option = get_keypress
			if valid_options.include? option
				#system('say "Valid option Selected" ')
				break
			else
				system('say "Select a Valid option" ')
			end 
		end # End of While
		return option.to_s
	end  # ............................................................................................................

	def show_main_menu

  		menu = { 	"1" => "Add a new contact",  
					"2" => "Modify an existing contact",
					"3" => "Delete a contact",
					"4" => "Display contacts",
					"5" => "Display an attribute",
					"6" => "Exit",
		}
		display_menu(menu)
	end  # ............................................................................................................


	def call_menu_option(user_selected)
  			
  			add_new_contact if user_selected == "1"
  			modify_contact if user_selected == "2"
  			delete_contact if user_selected == "3"
  			display_contact if user_selected == "4"
  			display_attribute if user_selected == "5"
  			exit_program if user_selected == "6"
  		
  	end # ............................................................................................................

	def exit_program #...............................................................................................+
		puts "Ending program !"
		sleep(2)
		exit 
	end #...........................................................................................................-

	def modify_contact #............................................................................................+
		print "Enter ID of the contact: "
		id = gets.chomp.to_i
		Contact.modify_using_id(id)
	end #...........................................................................................................-


	def display_attribute #.........................................................................................+
		menu = { 	"1" => "Sort by Attribute",  
					"2" => "Filter by Attribute",
					"0" => "Return to Main Menu"}
		option_selected = display_menu(menu)
		print "\n #{option_selected} \n"

		if (option_selected == "1") || (option_selected == "2")
			#return to main menu
			menu = { 	"1" => "Sort by ID",  
						"2" => "Sort by First Name",
						"3" => "Sort by Last Name",
						"4" => "Sort by Email",
						"0" => "Return to Main Menu"}
			option_selected = display_menu(menu)
			print "\n #{option_selected} \n"

			print "Ascending or Descending Order [A/D]"
			order = gets.chomp

			case option_selected
				when "1"
					Contact.display_all_with_sort("ID",order)
				when "2"
					Contact.display_all_with_sort("First_Name",order)
				when "3"
					Contact.display_all_with_sort("Last_Name",order)
				when "4"
					Contact.display_all_with_sort("Email",order)
			end 

		end


	end #...........................................................................................................-


	def add_new_contact #...........................................................................................+
		# Need to modify to allow only first and last name as mandatory.
	  	print "Enter First Name: "
	  	first_name = gets.chomp

	  	print "Enter Last Name: "
 	 	last_name = gets.chomp

	  	print "Enter Email Address: "
	  	email = gets.chomp

 	 	print "Enter a Note: "
 	 	note = gets.chomp

 	 	contact = Contact.create(first_name, last_name, email, note)

 	 	Contact.display_datatable_header
 	 		#binding.pry 
 	 		print "[%-05s]" % contact.id, " "  # Error
 	 		print "[%-15s]" % contact.first_name , " "
		  	print "[%-15s]" % contact.last_name , " "
		  	print "[%-30s]" % contact.email , " "
		  	print "[%-50s]" % contact.notes
		  	print "\n"

 	 	sleep(2)
	end # ............................................................................................................
	
	def display_contact #............................................................................................+

		menu = { 	"1" => "Display single contact",  
					"2" => "Display all contacts", }
		option_selected = display_menu(menu)
		puts "\n #{option_selected}"

		case option_selected
			when "1"
				print "Enter ID of the contact: "
				id = gets.chomp.to_i
				Contact.display_using_id(id)
				
			when "2"
				Contact.display_all
		end # case
	end  # ............................................................................................................


	def delete_contact #............................................................................................+

		menu = { 	"1" => "Delete single contact",  
					"2" => "TBD....", }

		option_selected = display_menu(menu)

		puts "\n #{option_selected}"
		#sleep(2)

		case option_selected 
			when "1"
				print "Enter ID of the contact: "
				id = gets.chomp.to_i
				Contact.delete_using_id(id)
			when "2"
				exit
		end # case
	end # ...........................................................................................................-
end # Class CRM



crm = CRM.new

Contact.create("FName 1", "SName1", "myemail1@domain.com", "Just a note")
Contact.create("FName 2", "SName2", "myemail2@domain.com", "Just a note")
Contact.create("FName 3", "SName3", "myemail3@domain.com", "Just a note")


while true do
		option_selected = crm.show_main_menu
		crm.call_menu_option(option_selected)
end 
