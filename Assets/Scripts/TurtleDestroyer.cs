using UnityEngine;

public class TurtleDestroyer : MonoBehaviour
{
    public bool isTrap = false;

    private void OnTriggerEnter(Collider other)
    {
        if (!enabled)
        {
            return;
        }
        Debug.Log($"TurtleDestroyer triggered on {other.gameObject}");
        Destroy(other.gameObject);
    }
}
