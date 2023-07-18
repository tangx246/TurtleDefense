using UnityEngine;

public class Egg : MonoBehaviour
{
    public float waitTimeSeconds;
    public GameObject turtlePrefab;

    void Start()
    {
        // Wait for waitTime seconds and then spawn the turtle
        Invoke("SpawnTurtle", waitTimeSeconds);
    }

    void SpawnTurtle()
    {
        // Spawn the turtle
        Instantiate(turtlePrefab, transform.position, transform.rotation);
        // Destroy the egg
        Destroy(gameObject);
    }
}
