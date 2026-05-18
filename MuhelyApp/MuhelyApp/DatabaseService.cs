using Microsoft.AspNetCore.Mvc.RazorPages;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Threading.Tasks;

public class DatabaseService
{
    private readonly UserSession _userSession;

    // Beinjektáljuk a bejelentkezett felhasználó adatait
    public DatabaseService(UserSession userSession)
    {
        _userSession = userSession;
    }

    // Teszteljük a kapcsolatot a belépésnél
    public async Task<bool> TestConnectionAsync(string username, string password)
    {
        string testConnString = $"User Id={username};Password={password};Data Source=localhost:1521/FREE;";
        try
        {
            using (var conn = new OracleConnection(testConnString))
            {
                await conn.OpenAsync();
                return true; // Ha sikerült megnyitni, jó a felhasználónév/jelszó
            }
        }
        catch
        {
            return false; // Ha hibát dob (pl. ORA-01017), elbukott a belépés
        }
    }

    // A frissített alkatrész lekérdezés, ami már a belépett felhasználót használja
    public async Task<List<PartModel>> GetPartsAsync()
    {
        var list = new List<PartModel>();

        // Itt kérjük le a dinamikus kapcsolat szöveget!
        using (var conn = new OracleConnection(_userSession.GetConnectionString()))
        {
            await conn.OpenAsync();

            // Ha user2-ként vagyunk bent, lehet hogy ki kell tenni a séma nevet (pl. SZAMT14.parts), 
            // kivéve ha csináltál nyilvános szinonimát. Teszteljük simán először:
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

    public async Task AddPartAsync(PartModel newPart)
    {
        using (var conn = new OracleConnection(_userSession.GetConnectionString()))
        {
            await conn.OpenAsync();

            // KIVETTÜK A PART_ID-t! Az Oracle most már automatikusan fogja generálni.
            string sql = @"INSERT INTO parts (name, description, quantity) 
                       VALUES (:name, :description, :quantity)";

            using (var cmd = new OracleCommand(sql, conn))
            {
                cmd.BindByName = true;

                cmd.Parameters.Add("name", OracleDbType.Varchar2).Value = newPart.Name;

                if (string.IsNullOrWhiteSpace(newPart.Description))
                {
                    cmd.Parameters.Add("description", OracleDbType.Varchar2).Value = DBNull.Value;
                }
                else
                {
                    cmd.Parameters.Add("description", OracleDbType.Varchar2).Value = newPart.Description;
                }

                cmd.Parameters.Add("quantity", OracleDbType.Int32).Value = newPart.Quantity;

                await cmd.ExecuteNonQueryAsync();
            }
        }
    }

    // --- KÉSZLET MÓDOSÍTÁSA OPTIMISTA EGYIDEJŰSÉG-KEZELÉSSEL ---
    // Visszatérési érték: true = sikeres, false = egyidejűségi hiba (más már módosította)
    public async Task<bool> UpdatePartQuantityAsync(int partId, int newQuantity, int oldQuantity)
    {
        using (var conn = new OracleConnection(_userSession.GetConnectionString()))
        {
            await conn.OpenAsync();

            // A WHERE feltételben szigorúan ellenőrizzük az 'oldQuantity'-t is!
            // Ha valaki időközben módosította az adatbázisban, a feltétel nem fog egyezni.
            string sql = @"UPDATE parts 
                       SET quantity = :newQuantity 
                       WHERE part_id = :partId AND quantity = :oldQuantity";

            using (var cmd = new OracleCommand(sql, conn))
            {
                cmd.BindByName = true;
                cmd.Parameters.Add("newQuantity", OracleDbType.Int32).Value = newQuantity;
                cmd.Parameters.Add("partId", OracleDbType.Int32).Value = partId;
                cmd.Parameters.Add("oldQuantity", OracleDbType.Int32).Value = oldQuantity;

                int rowsAffected = await cmd.ExecuteNonQueryAsync();

                // Ha 0 sor frissült, az azt jelenti, hogy az egyidejűségi ellenőrzés elbukott
                return rowsAffected > 0;
            }
        }
    }

public async Task<bool> FinalizeJobAndCreateInvoiceAsync(int jobId, int partId, int quantityUsed, decimal totalAmount, int customerId)
{
    using (var conn = new OracleConnection(_userSession.GetConnectionString()))
    {
        await conn.OpenAsync();

        using (var transaction = conn.BeginTransaction())
        {
            try
            {
                //Írjuk a számlát a megfelelő táblába (INVOICES)
                string sqlInvoice = @"INSERT INTO invoices (job_id, customer_id, amount, invoice_date) 
                                      VALUES (:jobId, :customerId, :amount, SYSDATE)";

                using (var cmd = new OracleCommand(sqlInvoice, conn))
                {
                    cmd.Transaction = transaction; // HOZZÁKÖTJÜK A TRANZAKCIÓHOZ!
                    cmd.Parameters.Add("jobId", OracleDbType.Int32).Value = jobId;
                    cmd.Parameters.Add("customerId", OracleDbType.Int32).Value = customerId;
                    cmd.Parameters.Add("amount", OracleDbType.Decimal).Value = totalAmount;
                    await cmd.ExecuteNonQueryAsync();
                }

                //Minden áru esetén kivonjuk a raktáron levő mennyiségből (PARTS)
                string sqlParts = @"UPDATE parts 
                                    SET quantity = quantity - :quantity 
                                    WHERE part_id = :partId";

                using (var cmd = new OracleCommand(sqlParts, conn))
                {
                    cmd.Transaction = transaction; // HOZZÁKÖTJÜK A TRANZAKCIÓHOZ!
                    cmd.Parameters.Add("quantity", OracleDbType.Int32).Value = quantityUsed;
                    cmd.Parameters.Add("partId", OracleDbType.Int32).Value = partId;
                    await cmd.ExecuteNonQueryAsync();
                }

                //Hozzáadjuk a megfelelő rendelés/munkalap elszállított státuszához (JOBS)
                string sqlJob = @"UPDATE jobs 
                                  SET status = 'COMPLETED', finished_at = SYSDATE 
                                  WHERE job_id = :jobId";

                using (var cmd = new OracleCommand(sqlJob, conn))
                {
                    cmd.Transaction = transaction; // HOZZÁKÖTJÜK A TRANZAKCIÓHOZ!
                    cmd.Parameters.Add("jobId", OracleDbType.Int32).Value = jobId;
                    await cmd.ExecuteNonQueryAsync();
                }

                //Megterheljük a vevőt a számla összértékével (CUSTOMERS)
                string sqlCustomer = @"UPDATE customers 
                                       SET balance = balance + :amount 
                                       WHERE customer_id = :customerId";

                using (var cmd = new OracleCommand(sqlCustomer, conn))
                {
                    cmd.Transaction = transaction; // HOZZÁKÖTJÜK A TRANZAKCIÓHOZ!
                    cmd.Parameters.Add("amount", OracleDbType.Decimal).Value = totalAmount;
                    cmd.Parameters.Add("customerId", OracleDbType.Int32).Value = customerId;
                    await cmd.ExecuteNonQueryAsync();
                }

                // Egyszerre, atomi módon beírjuk az egészet az adatbázisba!
                await transaction.CommitAsync();
                return true;
            }
            catch (Exception ex)
            {
                //Ha a fenti 4 lépés közül BÁRMELYIK hibába fut (pl. nincs elég raktárkészlet),
                //akkor az összes addigi módosítást rollebackelunk!
                await transaction.RollbackAsync();

                throw new Exception($"Tranzakció hiba! Minden módosítás visszavonva (Rollback). Részletek: {ex.Message}");
            }
        }
    }
}

}