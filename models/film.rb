require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end


  def save()
    sql = "INSERT INTO films
    (
      title,
      price
      ) VALUES
      (
        $1,$2
      )
      RETURNING id"
      values = [@title, @price]
      film = SqlRunner.run(sql,values).first
      @id = film['id'].to_i
    end


    def update()
      sql = "UPDATE films
      SET (
        title,
        price
        ) =
        (
          $1, $2
        )
        WHERE id = $3"
        values = [@title, @price, @id]
        SqlRunner.run(sql,values)
      end


      def delete
        sql = "DELETE FROM films WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
      end


      def customers()
        sql = "SELECT customers.* FROM customers
        INNER JOIN tickets
        ON tickets.customer_id = customers.id
        WHERE tickets.film_id = $1;"
        values = [@id]
        customers = SqlRunner.run(sql,values)
        results = customers.map { |customer| Customer.new(customer)  }
        return results
      end


      def num_of_customers()
        return customers().length
      end



      # Class methods

      def self.all()
        sql = "SELECT * FROM films"
        films = SqlRunner.run(sql)
        return Film.map_items(films)
      end


      def self.find(id)
        sql = "SELECT * FROM films WHERE id = $1"
        values = [id]
        films = SqlRunner.run(sql, values)
        return Film.map_items(films)
      end


      def self.delete_all()
        sql = "DELETE FROM films"
        values = []
        SqlRunner.run(sql, values)
      end

      def self.map_items(film_data)
        results = film_data.map { |film| Film.new(film) }
        return results
      end

    end
