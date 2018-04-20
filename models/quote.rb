class Quote < Model
  attr_accessor :departure_date
  attr_accessor :return_date
  attr_accessor :total_trip_cost

  attr_accessor :travelers

  attr_accessor :total_travellers #param represents total number of travelers
  attr_accessor :total_adults #param gives total number of adults in the quote
  attr_accessor :total_children #para gives total number of children in the quote
  attr_accessor :has_old_traveller #type of boolean param to check if we have got an old traveler 
  attr_accessor :given_single_age #for a single traveler request we set the age to this params

  def initialize(travelers: travelers,total_trip_cost: total_trip_cost)
    @travelers = travelers
    @total_trip_cost = total_trip_cost
  end

  def premium

    self.set_required_params

    case @has_old_traveller
      when 0
        case 
        #case for multi-travellers
        when @total_travellers>1
             
            case 
            when @total_adults == @total_children
                  case 
                  when (@total_adults==1) && (@total_children==1)
                     
                    case 
                    when (@total_trip_cost==0)
                        49.00
                    when (@total_trip_cost > 0)
                        144.00
                    end 
                    #infuture if new conditions need to be appended, just add cases 
                  end
            when (@total_children > @total_adults)
                    case 
                    when (@total_trip_cost==0)
                        73.00
                    when (@total_trip_cost > 0)
                        267.00
                    end 
            
            when (@total_adults > 1)  
                    case 
                    when (@total_trip_cost==0)
                        73.00
                    when (@total_trip_cost > 0)
                        338.00
                    end 
            end  
      #case for single-traveler  
      when @total_travellers ==1  

            case @given_single_age
            when 1..17
                case @total_trip_cost
                  when 5000
                    104.00
                  when 5001
                    116.00
                end

            when 18
                case @total_trip_cost
                  when 5000
                    104.00
                  when 5001
                    116.00
                end        
                
            when 45  
                case @total_trip_cost
                when 501
                    50.00
                when 0
                    35.00
                end
            end

      else
        0.0
      end  
    #for unavailable-product case  
    else
      nil
    end   
    
  end

  #this method is used to initialize the variables which can determine a particular type of quote.premium
  def set_required_params
    #these variable are used while generating premium amount
    #setting the default value of the variables

    @total_children=0
    @total_adults=0
    @has_old_traveller=0

    #getting the number of travelers
    @total_travellers = @travelers.length
    
    #iterating through each traveller to set the variables
      
    travelers.each do |i|
         if i.age<18
            if(@total_travellers ==1)
                @given_single_age = i.age
            end  
            @total_children += 1
        elsif i.age>=18
            if(@total_travellers ==1)
                @given_single_age = i.age
            end  
            if i.age > MAX_AGE
                @has_old_traveller = 1          
            end
            @total_adults += 1
        end
    end   

  end

end

