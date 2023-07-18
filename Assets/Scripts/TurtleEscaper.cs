using UnityEngine;

public class TurtleEscaper : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        Debug.Log($"TurtleEscaper triggered on {other.gameObject}");
        Destroy(other.gameObject);
    }
}
