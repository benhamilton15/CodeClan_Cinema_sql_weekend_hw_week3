require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end


  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
      ) VALUES
      (
        $1,$2
      )
      RETURNING id"
      values = [@customer_id, @film_id]
      ticket = SqlRunner.run(sql,values).first
      @id = ticket['id'].to_i
    end

    # does it need an update method? all instance variables are reliant on id's that should not be changed


    def delete
      sql = "DELETE FROM tickets WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end


    # Class methods


    def self.all()
      sql = "SELECT * FROM tickets"
      tickets = SqlRunner.run(sql)
      return Ticket.map_items(tickets)
    end


    def self.find(id)
      sql = "SELECT * FROM tickets WHERE id = $1"
      values = [id]
      tickets = SqlRunner.run(sql, values)
      return Ticket.map_items(tickets)
    end


    def self.delete_all()
      sql = "DELETE FROM tickets"
      values = []
      SqlRunner.run(sql, values)
    end


    def self.map_items(ticket_data)
      results = ticket_data.map { |ticket| Ticket.new(ticket) }
      return results
    end



  end
