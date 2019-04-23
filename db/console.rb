require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

require('pry')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new(
  {
    'name' => 'Ben',
    'fund' => '50'
  }
)

customer1.save()


customer2 = Customer.new(
  {
    'name' => 'Bob',
    'fund' => '100'
  }
)

customer2.save()

customer3 = Customer.new(
  {
    'name' => 'Roberto',
    'fund' => '1'
  }
)

customer3.save()





film1 = Film.new(
  {
    'title' => 'Critical Role The Movie',
    'price' => '5'
  }
)

film1.save()


film2 = Film.new(
  {
    'title' => 'Overwatch',
    'price' => '5'
  }
)

film2.save()


ticket1 = Ticket.new(
  {
    'customer_id' => customer1.id ,
    'film_id' => film1.id
  }
)

ticket1.save()


binding.pry
nil
