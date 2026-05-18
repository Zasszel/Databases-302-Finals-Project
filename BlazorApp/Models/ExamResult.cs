namespace BlazorApp.Models
{
    public class ExamResult
    {
        public int Pozitie { get; set; }
        public string Nr_Concurs { get; set; } = string.Empty;
        public string Judet { get; set; } = string.Empty;
        public string Nume_Prenume { get; set; } = string.Empty;
        public long? Scor_Simplu { get; set; }
        public decimal? Scor_Ponderat { get; set; }
        // Helper property set
        public int Year { get; set; }
        public bool IsAnonymous => Nume_Prenume.Contains("cerere anonimat");
    }
}
