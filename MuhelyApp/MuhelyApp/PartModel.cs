
   public class PartModel
    {
        // Az alkatrész egyedi azonosítója (Primary Key)
        public int PartId { get; set; }

        // Az alkatrész neve (VARCHAR2(20))
        public string Name { get; set; } = string.Empty;

        // Az alkatrész leírása (VARCHAR2(1000)), ami az adatbázisban lehet NULL is
        public string Description { get; set; } = string.Empty;

        // A raktáron lévő aktuális darabszám (NUMBER)
        public int Quantity { get; set; }
    }