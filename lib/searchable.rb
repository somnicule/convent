require_relative 'db_connection'

module Searchable
  def where(params)
    where_string = params.keys.map { |col| "#{col} = ?" }.join(' AND ')

    parse_all(DBConnection.execute(<<-SQL, *params.values))
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_string}
    SQL
  end
end