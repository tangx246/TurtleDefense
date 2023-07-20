using UnityEngine;

public class TurtleDestroyer : MonoBehaviour
{
    public bool isTrap = false;

    public GameManager gameManager;

    private void Awake()
    {
        gameManager = FindFirstObjectByType<GameManager>();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (!enabled)
        {
            return;
        }
        Debug.Log($"TurtleDestroyer triggered on {other.gameObject}");

        if (!isTrap)
        {
            gameManager.TurtleEscaped();
        }

        Destroy(other.gameObject.transform.parent.gameObject);
    }
}
