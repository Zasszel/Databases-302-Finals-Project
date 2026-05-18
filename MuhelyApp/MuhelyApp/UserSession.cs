using System;

public class UserSession
{
    public string Username { get; private set; } = string.Empty;
    public string Password { get; private set; } = string.Empty;
    public bool IsLoggedIn => !string.IsNullOrEmpty(Username);

    public bool IsAdmin => Username.ToLower() == "system" || Username.ToLower() == "szamt14";
    public bool IsMechanic => Username.ToLower() == "user1" || Username.ToLower().Contains("mechanic");
    public bool IsWarehouse => Username.ToLower() == "user2" || Username.ToLower() == "user3" || Username.ToLower().Contains("raktar");

    //Esemény, amire a menü fel tud iratkozni
    public event Action? OnChange;

    public void Login(string username, string password)
    {
        Username = username;
        Password = password;
        NotifyStateChanged(); // Értesítjük a menüt
    }

    public void Logout()
    {
        Username = string.Empty;
        Password = string.Empty;
        NotifyStateChanged(); // Értesítjük a menüt
    }

    //Szól mindenkinek, aki figyel
    private void NotifyStateChanged() => OnChange?.Invoke();

    public string GetConnectionString()
    {
        return $"User Id={Username};Password={Password};Data Source=localhost:1521/FREE;";
    }
}