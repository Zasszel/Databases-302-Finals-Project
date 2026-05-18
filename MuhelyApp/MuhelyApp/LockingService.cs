using System;
using System.Collections.Concurrent;

public class LockingService
{
    private readonly ConcurrentDictionary<int, string> _lockedParts = new();

    public event Action? OnLockChanged;
    //Esemény, ami szól, ha az adatbázisban változott valami
    public event Action? OnDataChanged;

    public bool TryLockPart(int partId, string username)
    {
        if (_lockedParts.TryAdd(partId, username))
        {
            OnLockChanged?.Invoke();
            return true;
        }
        return false;
    }

    public void ReleaseLock(int partId, string username)
    {
        if (_lockedParts.TryGetValue(partId, out string? lockedBy) && lockedBy == username)
        {
            _lockedParts.TryRemove(partId, out _);
            OnLockChanged?.Invoke();
        }
    }

    public void NotifyDataChanged()
    {
        OnDataChanged?.Invoke();
    }

    public string? GetLockOwner(int partId)
    {
        _lockedParts.TryGetValue(partId, out string? owner);
        return owner;
    }

    public bool IsLockedBySomeoneElse(int partId, string currentUsername)
    {
        return _lockedParts.TryGetValue(partId, out string? owner) && owner != currentUsername;
    }
}