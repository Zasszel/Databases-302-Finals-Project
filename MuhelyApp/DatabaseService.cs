using Oracle.ManagedDataAccess.Client;
using System.Data;

public class DatabaseService
{
    private readonly string _connectionString;

    public DatabaseService(IConfiguration configuration)
    {
        // Kiolvassa a kapcsolatot az appsettings.json-ből
        _connectionString = configuration.GetConnectionString("OracleDb");
    }

    // Lekérjük az alkatrészeket a táblázathoz
    public async Task<List<PartModel>> GetPartsAsync()
    {
        var list = new List<PartModel>();

        using (var conn = new OracleConnection(_connectionString))
        {
            await conn.OpenAsync();
            using (var cmd = new OracleCommand("SELECT part_id, name, description, quantity FROM parts", conn))
            {
                using (var reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        list.Add(new PartModel
                        {
                            PartId = reader.GetInt32(0),
                            Name = reader.GetString(1),
                            Description = reader.IsDBNull(2) ? "" : reader.GetString(2),
                            Quantity = reader.GetInt32(3)
                        });
                    }
                }
            }
        }
        return list;
    }
}

// Egyszerű adatmodell az alkatrésznek
public class PartModel
{
    public int PartId { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public int Quantity { get; set; }
}