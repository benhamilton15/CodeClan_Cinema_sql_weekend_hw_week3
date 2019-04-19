require_relative('../db/sql_runner')

class Customer

  attr_reader :id, :fund
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @fund = options['fund'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      fund
      ) VALUES
      (
        $1,$2
      )
      RETURNING id"
      values = [@name, @fund]
      customer = SqlRunner.run(sql,values).first
      @id = customer['id'].to_i
    end

    def update()
    sql = "UPDATE customers
    SET (
      name,
      fund
      ) =
      (
        $1, $2
      )
      WHERE id = $3"
      values = [@name, @fund, @id]
      SqlRunner.run(sql,values)
    end

    def delete

    end

    def films()
      sql = "SELECT films.* FROM films
      INNER JOIN tickets
      ON tickets.film_id = films.id
      WHERE tickets.film_id = $1;"
      values = [@id]
      films = SqlRunner.run(sql,values)
      results = films.map { |film| Film.new(film)  }
      return results
    end




    def self.all()
      sql = "SELECT * FROM customers"
      customers = SqlRunner.run(sql)
      return Customer.map_items(customers)
    end

    def self.delete_all()
      sql = "DELETE FROM customers"
      values = []
      SqlRunner.run(sql, values)
    end

    def self.map_items(customer_data)
      results = customer_data.map { |customer| Customer.new(customer) }
      return results
    end



  end