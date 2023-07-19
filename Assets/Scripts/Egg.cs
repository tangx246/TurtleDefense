using UnityEngine;

public class Egg : MonoBehaviour
{
    public float waitTimeSeconds;
    public float hatchAnimationTimeSeconds = 0.458f;
    public GameObject turtlePrefab;

    private new Animation animation;

    private void Awake()
    {
        animation = GetComponentInChildren<Animation>();
    }

    void Start()
    {
        // Wait for waitTime seconds and then spawn the turtle
        Invoke("SpawnTurtle", waitTimeSeconds);
        Invoke("PlayHatchAnimation", waitTimeSeconds - hatchAnimationTimeSeconds);
    }

    void SpawnTurtle()
    {
        // Spawn the turtle
        Instantiate(turtlePrefab, transform.position, transform.rotation);
        // Destroy the egg
        Destroy(gameObject);
    }

    private void PlayHatchAnimation()
    {
        animation.Play(PlayMode.StopAll);
    }
}
